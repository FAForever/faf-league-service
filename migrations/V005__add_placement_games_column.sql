ALTER table league_season
ADD COLUMN `placement_games` INTEGER NOT NULL DEFAULT 10 AFTER leaderboard_id
;
UPDATE league_season SET placement_games = 10;
