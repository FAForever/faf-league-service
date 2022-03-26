ALTER table league_season
ADD COLUMN `placement_games_returning_player` INTEGER NOT NULL DEFAULT 4 AFTER placement_games;
UPDATE league_season SET placement_games_returning_player = 4;

ALTER table league_season_score
ADD COLUMN `returning_player` BOOLEAN NOT NULL DEFAULT FALSE AFTER game_count;
UPDATE league_season_score SET returning_player = FALSE;