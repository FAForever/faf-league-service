UPDATE league SET technical_name = "2v2_league", name_key = "2v2_league.name", description_key = "2v2_league.description"
WHERE id = 1;
UPDATE league SET technical_name = "1v1_league", name_key = "1v1_league.name", description_key = "1v1_league.description"
WHERE id = 2;

UPDATE league_season SET name_key = "2v2_league.season.1" WHERE id = 1;
UPDATE league_season SET name_key = "1v1_league.season.1" WHERE id = 2;
UPDATE league_season SET name_key = "2v2_league.season.2" WHERE id = 3;
UPDATE league_season SET name_key = "1v1_league.season.2" WHERE id = 4;
