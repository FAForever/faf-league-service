from datetime import datetime, timedelta

import aiocron
from dateutil.relativedelta import relativedelta
from sqlalchemy import func, insert, select

from service.config import SEASON_GENERATION_DAYS_BEFORE_SEASON_END
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
            sql = select([league]).where(league.c.enabled is True)
            result = await conn.execute(sql)
            rows = await result.fetchall()

            now = datetime.now()
            year = now.year
            month = now.month
            if month == 12:
                month = 1
                year += 1
            else:
                month += 1
            # season starts and ends at noon, so that all timezones see the same date in the client
            start_date = datetime(year=year, month=month, day=1, hour=12)
            end_date = start_date + relativedelta(months=3) - relativedelta(days=1)

            for row in rows:
                await self.update_db(conn, row, start_date, end_date)

    async def update_db(self, conn, league_row, start_date, end_date):
        season_sql = select([league_season]).where(league_season.c.league_id == league_row[league.c.id])
        season_row = await conn.execute(season_sql).fetchall()
        season_id = conn.execute(select([func.max(league_season.c.id)])).scalar() + 1
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
        season_division_rows = await conn.execute(division_sql).fetchall()
        season_division_id = conn.execute(select([func.max(league_season.c.id)])).scalar()
        for row in season_division_rows:
            division_index = row[league_season_division.c.division_index]
            season_division_id += 1
            division_insert_sql = (
                insert(league_season_division)
                .values(
                    id=season_division_id,
                    league_season_id=season_id,
                    division_index=division_index,
                    description_key=(
                        "%s_%s.division.%s",
                        season_row[league_season.c.name_key],
                        season_number,
                        division_index,
                    ),
                    name_key=row[league_season_division.c.name_key]
                )
            )
            await conn.execute(division_insert_sql)

            subdivision_sql = (
                select([league_season_division_subdivision])
                .where(league_season_division_subdivision.c.league_season_division_id == season_division_id)
            )
            subdivision_rows = await conn.execute(subdivision_sql).fetchall()
            for subdivision_row in subdivision_rows:
                subdivision_index = row[league_season_division_subdivision.c.subdivision_index]
                subdivision_insert_sql = (
                    insert(league_season_division_subdivision)
                    .values(
                        league_season_division_id=season_division_id,
                        subdivision_index=subdivision_index,
                        description_key=(
                            "%s_%s.subdivision.%s.%s",
                            season_row[league_season.c.name_key],
                            season_number,
                            division_index,
                            subdivision_index,
                        ),
                        min_rating=subdivision_row[league_season_division_subdivision.c.min_rating],
                        max_rating=subdivision_row[league_season_division_subdivision.c.max_rating],
                        highest_score=subdivision_row[league_season_division_subdivision.c.highest_score],
                        name_key=row[league_season_division_subdivision.c.name_key]
                    )
                )
                await conn.execute(subdivision_insert_sql)
