from datetime import datetime, timedelta
from unittest import mock

import pytest
from freezegun import freeze_time
from sqlalchemy import select

from service.db.models import (league_season, league_season_division,
                               league_season_division_subdivision)
from service.season_generator import SeasonGenerator


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
        seasons = await conn.execute(select(league_season))
        rows = seasons.fetchall()
        assert len(rows) == 7
        assert max(row.season_number for row in rows) == 5

        divisions = await conn.execute(select(league_season_division))
        rows = divisions.fetchall()
        assert len(rows) == 11
        new_division_one = await conn.execute(select(league_season_division).where(league_season_division.c.id == 10))
        row = new_division_one.fetchone()
        assert row.league_season_id == 7
        assert row.division_index == 1
        assert row.name_key == "L2S1D1"
        assert row.description_key == "second_test_league.season.1_2.division.1"

        subdivisions = await conn.execute(select(league_season_division_subdivision))
        rows = subdivisions.fetchall()
        assert len(rows) == 12
        new_subdivision = await conn.execute(
            select(league_season_division_subdivision)
            .where(league_season_division_subdivision.c.league_season_division_id == 10)
        )
        row = new_subdivision.fetchone()
        assert row.subdivision_index == 1
        assert row.name_key == "L2S1D1SD1"
        assert row.description_key == "second_test_league.season.1_2.subdivision.1.1"
        assert row.min_rating == 0
        assert row.max_rating == 3000
        assert row.highest_score == 20


async def test_generate_season_only_once(season_generator, database):
    await season_generator.check_season_end()
    await season_generator.check_season_end()
    async with database.acquire() as conn:
        seasons = await conn.execute(select(league_season))
        rows = seasons.fetchall()
        assert len(rows) == 7
        assert max(row.season_number for row in rows) == 5
