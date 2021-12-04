ALTER table league_season
ADD COLUMN `season_number` INTEGER NOT NULL AFTER placement_games;

UPDATE league_season SET season_number = 1 WHERE id = 1;
UPDATE league_season SET season_number = 1 WHERE id = 2;
UPDATE league_season SET season_number = 2 WHERE id = 3;
UPDATE league_season SET season_number = 2 WHERE id = 4;