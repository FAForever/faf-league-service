from datetime import datetime, timedelta

import aiocron
from dateutil.relativedelta import relativedelta
from sqlalchemy import desc, func, insert, select

from service.config import (SEASON_GENERATION_DAYS_BEFORE_SEASON_END,
                            SEASON_LENGTH_MONTHS)
from service.db import FAFDatabase
from service.db.models import (league, league_season, league_season_division,
                               league_season_division_subdivision)
from service.decorators import with_logger


@with_logger
class SeasonGenerator:
    def __init__(self, database: FAFDatabase):
        self._logger.info("Season generator created.")
        self._db = database

    def initialize(self):
        self._update_cron = aiocron.crontab(
            "0 0 * * *", func=self.check_season_end
        )

    async def check_season_end(self):
        self._logger.debug("Checking if latest season ends soon.")
        async with self._db.acquire() as conn:
            sql = select([league_season])
            result = await conn.execute(sql)
            rows = await result.fetchall()

            max_date = max(row[league_season.c.end_date] for row in rows)

        if max_date < datetime.now() + timedelta(days=SEASON_GENERATION_DAYS_BEFORE_SEASON_END):
            try:
                await self.generate_season()
            except Exception:
                self._logger.exception("Failed to generate new season")
            else:
                self._logger.info("Season successfully created!")

    async def generate_season(self):
        self._logger.info("Generating new season...")
        async with self._db.acquire() as conn:
            sql = select([league]).where(league.c.enabled == True)
            result = await conn.execute(sql)
            rows = await result.fetchall()

            next_month = datetime.now() + relativedelta(months=1)
            # season starts and ends at noon, so that all timezones see the same date in the client
            start_date = datetime(year=next_month.year, month=next_month.month, day=1, hour=12)
            end_date = start_date + relativedelta(months=SEASON_LENGTH_MONTHS) - relativedelta(days=1)

            for row in rows:
                await self.update_db(conn, row, start_date, end_date)

    async def update_db(self, conn, league_row, start_date, end_date):
        season_sql = (
            select([league_season])
            .where(league_season.c.league_id == league_row[league.c.id])
            .order_by(desc(league_season.c.season_number))
            .limit(1)
        )
        result = await conn.execute(season_sql)
        season_row = await result.fetchone()
        if season_row is None:
            self._logger.warning(
                "No season found for league %s. Skipping this league",
                league_row[league.c.technical_name]
            )
            return
        result = await conn.execute(select([func.max(league_season.c.id)]))
        season_id = await result.scalar() + 1
        season_number = season_row[league_season.c.season_number] + 1
        season_insert_sql = (
            insert(league_season)
            .values(
                id=season_id,
                league_id=season_row[league_season.c.league_id],
                leaderboard_id=season_row[league_season.c.leaderboard_id],
                placement_games=season_row[league_season.c.placement_games],
                season_number=season_number,
                name_key=season_row[league_season.c.name_key],
                start_date=start_date,
                end_date=end_date,
            )
        )
        await conn.execute(season_insert_sql)

        division_sql = (
            select([league_season_division])
            .where(league_season_division.c.league_season_id == season_row[league_season.c.id])
        )
        result = await conn.execute(division_sql)
        season_division_rows = await result.fetchall()
        if len(season_division_rows) == 0:
            self._logger.warning(
                "No divisions found for season id %s. No divisions could be created. "
                "Now season id %s has no divisions as well. This needs to be fixed manually",
                season_row[league_season.c.id],
                season_id
            )
            return
        result = await conn.execute(select([func.max(league_season_division.c.id)]))
        division_id = await result.scalar()
        for division_row in season_division_rows:
            division_index = division_row[league_season_division.c.division_index]
            division_id += 1
            division_insert_sql = (
                insert(league_season_division)
                .values(
                    id=division_id,
                    league_season_id=season_id,
                    division_index=division_index,
                    description_key=(
                        f"{season_row[league_season.c.name_key]}_{season_number}.division.{division_index}"
                    ),
                    name_key=division_row[league_season_division.c.name_key],
                )
            )
            await conn.execute(division_insert_sql)

            subdivision_sql = (
                select([league_season_division_subdivision])
                .where(league_season_division_subdivision.c.league_season_division_id ==
                       division_row[league_season_division.c.id])
            )
            result = await conn.execute(subdivision_sql)
            subdivision_rows = await result.fetchall()
            if len(subdivision_rows) == 0:
                self._logger.warning(
                    "No subdivisions found for division id %s. No subdivisions could be created. "
                    "Now division id %s has no subdivisions as well. This needs to be fixed manually",
                    division_row[league_season_division.c.id],
                    division_id
                )
                return
            for subdivision_row in subdivision_rows:
                subdivision_index = subdivision_row[league_season_division_subdivision.c.subdivision_index]
                subdivision_insert_sql = (
                    insert(league_season_division_subdivision)
                    .values(
                        league_season_division_id=division_id,
                        subdivision_index=subdivision_index,
                        description_key=(
                            f"{season_row[league_season.c.name_key]}_{season_number}"
                            f".subdivision.{division_index}.{subdivision_index}"
                        ),
                        name_key=subdivision_row[league_season_division_subdivision.c.name_key],
                        min_rating=subdivision_row[league_season_division_subdivision.c.min_rating],
                        max_rating=subdivision_row[league_season_division_subdivision.c.max_rating],
                        highest_score=subdivision_row[league_season_division_subdivision.c.highest_score],
                    )
                )
                await conn.execute(subdivision_insert_sql)
