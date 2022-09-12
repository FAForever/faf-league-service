from datetime import datetime, timedelta
from unittest.mock import patch

import pytest
from sqlalchemy import select

from service.db.models import league_season
from service.season_generator import SeasonGenerator


@pytest.fixture
def season_generator(database):
    season_generator = SeasonGenerator(database)
    season_generator.initialize()
    return season_generator


@patch('season_generator.now')
def test_early_season_check(season_generator, mock_now):
    mock_now.return_value = datetime.now() - timedelta(days=5)
    await season_generator.check_season_end()
    assert season_generator._db.acquire().call_count == 1


@patch('season_generator.now')
def test_late_season_check(season_generator, mock_now):
    mock_now.return_value = datetime.now() + timedelta(days=5)
    await season_generator.check_season_end()
    assert season_generator._db.acquire().call_count == 2


@patch('season_generator.now')
def test_season_check_after_season_end(season_generator, mock_now):
    mock_now.return_value = datetime.now() + timedelta(days=20)
    await season_generator.check_season_end()
    assert season_generator._db.acquire().call_count == 2


def test_generate_season(season_generator, database):
    await season_generator.generate_season()
    async with database.acquire() as conn:
        result = await conn.execute(select([league_season]))
        rows = await result.fetchall()
        assert len(rows) == 7
        assert max(rows[league_season.c.season_number]) == 4


