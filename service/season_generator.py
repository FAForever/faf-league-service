from datetime import datetime, timedelta

import aiocron
from sqlalchemy import select, text

from service.config import SEASON_GENERATION_DAYS_BEFORE_SEASON_END
from service.db import FAFDatabase
from service.db.models import league_season
from service.decorators import with_logger


@with_logger
class SeasonGenerator:
    def __int__(self, database: FAFDatabase):
        self._db = database

    def initialize(self):
        self._update_cron = aiocron.crontab(
            "0 0 * * *", func=self.check_season_end()
        )

    # We need this for testing
    def now(self):
        return datetime.now()

    async def check_season_end(self):
        self._logger.debug("Checking if latest season ends soon.")
        async with self._db.acquire() as conn:
            sql = (
                select([league_season])
            )
            result = await conn.execute(sql)
            rows = await result.fetchall()

            max_date = max(rows[league_season.c.end_date])

            if max_date < self.now() + timedelta(days=SEASON_GENERATION_DAYS_BEFORE_SEASON_END):
                try:
                    await self.generate_season()
                except Exception as e:
                    self._logger.exception("Failed to generate new season. Raised exception %s", e)
                else:
                    self._logger.info("Season successfully created!")

    async def generate_season(self):
        self._logger.info("Generating new season...")
        async with self._db.acquire() as conn:
            with open("generate_season.sql") as file:
                query = text(file.read())
                await conn.execute(query)




