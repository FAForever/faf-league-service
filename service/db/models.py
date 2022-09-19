from sqlalchemy import (TIMESTAMP, Boolean, Column, Float, ForeignKey, Integer,
                        MetaData, String, Table)

metadata = MetaData()

# Note that not all columns are listed here

leaderboard = Table(
    "leaderboard",
    metadata,
    Column("id",             Integer, primary_key=True),
    Column("technical_name", String, nullable=False, unique=True),
)

league = Table(
    "league",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("technical_name", String, nullable=False, unique=True),
    Column("enabled", Boolean, nullable=False),
    Column("image_url", String, nullable=False),
    Column("medium_image_url", String, nullable=False),
    Column("small_image_url", String, nullable=False),
)

league_season = Table(
    "league_season",
    metadata,
    Column("id",              Integer, primary_key=True),
    Column("league_id",       Integer, ForeignKey("league.id")),
    Column("leaderboard_id",  Integer, ForeignKey("leaderboard.id")),
    Column("name_key",        String),
    Column("placement_games", Integer),
    Column("placement_games_returning_player", Integer),
    Column("start_date",      TIMESTAMP),
    Column("end_date",        TIMESTAMP),
)

league_season_division = Table(
    "league_season_division",
    metadata,
    Column("id",               Integer, primary_key=True),
    Column("league_season_id", Integer, ForeignKey("league_season.id")),
    Column("division_index",   Integer),
)

league_season_division_subdivision = Table(
    "league_season_division_subdivision",
    metadata,
    Column("id",                        Integer, primary_key=True),
    Column("league_season_division_id", Integer, ForeignKey("league_season_division.id")),
    Column("subdivision_index",         Integer),
    Column("min_rating",                Float),
    Column("max_rating",                Float),
    Column("highest_score",             Integer),
)

league_season_score = Table(
    "league_season_score",
    metadata,
    Column("id",               Integer, primary_key=True),
    Column("login_id",         Integer, ForeignKey("login.id")),
    Column("league_season_id", Integer, ForeignKey("league_season.id")),
    Column("subdivision_id",   Integer, ForeignKey("league_season_division_subdivision.id")),
    Column("score",            Integer),
    Column("game_count",       Integer),
    Column("returning_player", Boolean),
)

league_score_journal = Table(
    "league_score_journal",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("login_id", Integer, ForeignKey("login.id")),
    Column("league_season_id", Integer, ForeignKey("league_season.id")),
    Column("subdivision_id_before", Integer, ForeignKey("league_season_division_subdivision.id")),
    Column("subdivision_id_after", Integer, ForeignKey("league_season_division_subdivision.id")),
    Column("score_before", Integer),
    Column("score_after", Integer),
    Column("game_count", Integer),
)
