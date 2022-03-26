ALTER table league_season
ADD COLUMN `placement_games_veteran` INTEGER NOT NULL DEFAULT 4 AFTER placement_games
;
UPDATE league_season SET placement_games_veteran = 4;
