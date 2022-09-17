from datetime import datetime, timedelta

import mock
import pytest
from freezegun import freeze_time
from sqlalchemy import select

from service.db.models import league_season
from service.season_generator import SeasonGenerator

pytestmark = pytest.mark.asyncio


@pytest.fixture
def season_generator(database):
    season_generator = SeasonGenerator(database)
    season_generator.initialize()
    return season_generator


@freeze_time(datetime.now() - timedelta(days=5))
async def test_early_season_check(season_generator):
    season_generator.generate_season = mock.Mock()
    await season_generator.check_season_end()
    assert season_generator.generate_season.call_count == 0


@freeze_time(datetime.now() + timedelta(days=5))
async def test_late_season_check(season_generator):
    season_generator.generate_season = mock.Mock()
    await season_generator.check_season_end()
    assert season_generator.generate_season.call_count == 1


@freeze_time(datetime.now() + timedelta(days=20))
async def test_season_check_after_season_end(season_generator):
    season_generator.generate_season = mock.Mock()
    await season_generator.check_season_end()
    assert season_generator.generate_season.call_count == 1


async def test_generate_season(season_generator, database):
    await season_generator.generate_season()
    async with database.acquire() as conn:
        result = await conn.execute(select([league_season]))
        rows = await result.fetchall()
        assert len(rows) == 7
        assert max(row[league_season.c.season_number] for row in rows) == 4


