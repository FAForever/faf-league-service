import pytest
from asynctest import CoroutineMock
from sqlalchemy import select

from service.db.models import league_score_journal
from service.league_service import LeagueService
from service.league_service.league_service import ServiceNotReadyError
from service.league_service.typedefs import (InvalidScoreError, League,
                                             LeagueScore)

pytestmark = pytest.mark.asyncio


@pytest.fixture
async def league_service(database, message_queue_service):
    service = LeagueService(database, message_queue_service)
    await service.initialize()
    yield service
    service.kill()


@pytest.fixture
def uninitialized_service(database, message_queue_service):
    return LeagueService(database, message_queue_service)


@pytest.fixture
def rating_change_message():
    return {
        "player_id": 1,
        "rating_type": "global",
        "new_rating_mean": 1200,
        "new_rating_deviation": 200,
        "game_id": 1,
        "outcome": "VICTORY",
    }


async def test_enqueue_manual_initialization(
    uninitialized_service, rating_change_message
):
    service = uninitialized_service
    await service.initialize()
    service._rate_single_league = CoroutineMock()
    await service.enqueue(rating_change_message)
    await service.shutdown()

    service._rate_single_league.assert_called()


async def test_double_initialization_does_not_start_second_worker(league_service):
    worker_task_id = id(league_service._task)

    await league_service.initialize()

    assert worker_task_id == id(league_service._task)


async def test_enqueue_initialized(league_service, rating_change_message):
    service = league_service
    service._rate_single_league = CoroutineMock()

    await service.enqueue(rating_change_message)
    await service.shutdown()

    service._rate_single_league.assert_called()


async def test_enqueue_uninitialized(uninitialized_service, rating_change_message):
    service = uninitialized_service
    with pytest.raises(ServiceNotReadyError):
        await service.enqueue(rating_change_message)
    await service.shutdown()


async def test_update_data(uninitialized_service):
    service = uninitialized_service
    await service.update_data()

    assert sorted(list(service._leagues_by_rating_type.keys())) == [
        "global",
        "ladder_1v1",
    ]

    assert len(service._leagues_by_rating_type["global"]) == 1
    test_league = service._leagues_by_rating_type["global"][0]
    assert test_league.current_season_id == 2
    assert test_league.rating_type == "global"
    assert len(test_league.divisions) == 6
    assert [division.min_rating for division in test_league.divisions] == [
        0,
        100,
        200,
        300,
        400,
        500,
    ]
    assert [division.max_rating for division in test_league.divisions] == [
        100,
        200,
        300,
        400,
        500,
        600,
    ]
    assert [division.highest_score for division in test_league.divisions] == [
        10,
        10,
        10,
        10,
        10,
        100,
    ]


async def test_is_returning_player(league_service):
    player_id = 2
    rating_type = "global"

    is_returning = await league_service.is_returning_player(player_id, rating_type)

    assert is_returning


async def test_load_score(league_service):
    player_id = 1
    rating_type = "global"
    expected_division_id = 5
    expected_score = 3
    expected_game_count = 15
    expected_returning_player = True

    league = league_service._leagues_by_rating_type[rating_type][0]
    league_score = await league_service._load_score(player_id, league)

    assert league_score.division_id == expected_division_id
    assert league_score.score == expected_score
    assert league_score.game_count == expected_game_count
    assert league_score.returning_player == expected_returning_player


async def test_load_score_player_does_not_exist(league_service):
    non_player_id = 666
    rating_type = "global"

    league = league_service._leagues_by_rating_type[rating_type][0]
    league_score = await league_service._load_score(non_player_id, league)

    assert league_score == LeagueScore(None, None, 0, False)


async def test_load_score_league_does_not_exist(league_service):
    player_id = 1
    unknown_league = League(
        "unknown",
        [],
        666,
        10,
        4,
        "unknown leaderboard"
    )

    league_score = await league_service._load_score(player_id, unknown_league)

    # TODO maybe this should throw an exception instead?
    assert league_score == LeagueScore(None, None, 0, False)


async def test_persist_score_new_player(league_service, database):
    game_id = 1
    new_player_id = 5
    season_id = 2
    division_id = 3
    score = 6
    game_count = 42
    returning = False
    old_score = LeagueScore(division_id, score, game_count, returning)
    new_score = LeagueScore(division_id, score - 1, game_count + 1, returning)

    await league_service._persist_score(game_id, new_player_id, season_id, old_score, new_score)

    league = league_service._leagues_by_rating_type["global"][0]
    loaded_score = await league_service._load_score(new_player_id, league)
    assert loaded_score == new_score

    async with database.acquire() as conn:
        result = await conn.execute(select([league_score_journal]))
        rows = await result.fetchall()
        assert len(rows) == 1
        for row in rows:
            assert row["game_id"] == 1
            assert row["login_id"] == 5
            assert row["league_season_id"] == 2
            assert row["subdivision_id_before"] == 3
            assert row["subdivision_id_after"] == 3
            assert row["score_before"] == 6
            assert row["score_after"] == 5
            assert row["game_count"] == 43


async def test_persist_score_old_player(league_service, database):
    game_id = 10
    old_player_id = 1
    season_id = 2
    division_id = 3
    score = 6
    game_count = 42
    returning = True
    old_score = LeagueScore(division_id, score, game_count, returning)
    new_score = LeagueScore(division_id, score - 1, game_count + 1, returning)

    await league_service._persist_score(game_id, old_player_id, season_id, old_score, new_score)

    league = league_service._leagues_by_rating_type["global"][0]
    loaded_score = await league_service._load_score(old_player_id, league)
    assert loaded_score == new_score

    async with database.acquire() as conn:
        result = await conn.execute(select([league_score_journal]))
        rows = await result.fetchall()
        assert len(rows) == 1
        for row in rows:
            assert row["game_id"] == 10
            assert row["login_id"] == 1
            assert row["league_season_id"] == 2
            assert row["subdivision_id_before"] == 3
            assert row["subdivision_id_after"] == 3
            assert row["score_before"] == 6
            assert row["score_after"] == 5
            assert row["game_count"] == 43


async def test_persist_score_season_id_mismatch(league_service):
    game_id = 10
    player_id = 1
    wrong_season_id = 1
    division_id = 3
    score = 6
    game_count = 42
    returning = False
    old_score = LeagueScore(division_id, score, game_count, returning)
    new_score = LeagueScore(division_id, score - 1, game_count + 1, returning)

    with pytest.raises(InvalidScoreError):
        await league_service._persist_score(game_id, player_id, wrong_season_id, old_score, new_score)


async def test_persist_score_division_without_score(league_service):
    game_id = 10
    player_id = 1
    season_id = 2
    division_id = 3
    no_score = None
    game_count = 42
    returning = False
    old_score = LeagueScore(None, no_score, game_count, returning)
    new_score = LeagueScore(division_id, no_score, game_count + 1, returning)

    with pytest.raises(InvalidScoreError):
        await league_service._persist_score(game_id, player_id, season_id, old_score, new_score)
