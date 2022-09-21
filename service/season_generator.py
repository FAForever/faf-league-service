from datetime import datetime, timedelta

import aiocron
from sqlalchemy import select, text

from service.config import SEASON_GENERATION_DAYS_BEFORE_SEASON_END
from service.db import FAFDatabase
from service.db.models import league_season
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
            sql = (select([league_season]))
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
            with open("service/generate_season.sql") as file:
                query = text(file.read())
                await conn.execute(query)
