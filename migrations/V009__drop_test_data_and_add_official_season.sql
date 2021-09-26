DELETE FROM league
DELETE FROM league_season
DELETE FROM league_season_division
DELETE FROM league_season_division_subdivision
DELETE FROM league_season_score

INSERT INTO league (id, technical_name, image_key, medium_image_key, small_image_key, name_key, description_key) VALUES
  (1, "Ladder1v1League", "https://content.faforever.com/divisions/icons/", "https://content.faforever.com/divisions/icons/medium/", "https://content.faforever.com/divisions/icons/small/", "Ladder1v1League.name", "Ladder1v1League.description"),
  (2, "TMM2v2League", "https://content.faforever.com/divisions/icons/", "https://content.faforever.com/divisions/icons/medium/", "https://content.faforever.com/divisions/icons/small/", "TMM2v2League.name", "TMM2v2League.description");

INSERT INTO league_season (id, league_id, leaderboard_id, placement_games, name_key, start_date, end_date) VALUES
  (1, 1, 2, 10, "1v1League.season.1", "2021-12-01 00:00:00", "2022-03-31 23:59:00"),
  (2, 2, 3, 10, "2v2League.season.1", "2021-12-01 00:00:00", "2022-03-31 23:59:00");

INSERT INTO league_season_division (id, league_season_id, division_index, description_key, name_key) VALUES
  ( 1, 1, 1, "1v1Season1.division.1", "bronze"),
  ( 2, 1, 2, "1v1Season1.division.2", "silver"),
  ( 3, 1, 3, "1v1Season1.division.3", "gold"),
  ( 4, 1, 4, "1v1Season1.division.4", "diamond"),
  ( 5, 1, 5, "1v1Season1.division.5", "master"),
  ( 6, 1, 6, "1v1Season1.division.6", "grandmaster"),
  ( 7, 2, 1, "2v2Season1.division.1", "bronze"),
  ( 8, 2, 2, "2v2Season1.division.2", "silver"),
  ( 9, 2, 3, "2v2Season1.division.3", "gold"),
  (10, 2, 4, "2v2Season1.division.4", "diamond"),
  (11, 2, 5, "2v2Season1.division.5", "master"),
  (12, 2, 6, "2v2Season1.division.6", "grandmaster");

INSERT INTO league_season_division_subdivision (league_season_division_id, subdivision_index, description_key, min_rating, max_rating, highest_score, name_key) VALUES
  ( 1, 1, "1v1Season1.subdivision.1.1", -800,  -40, 10, "V"),
  ( 1, 2, "1v1Season1.subdivision.1.2",  -40,   45, 10, "IV"),
  ( 1, 3, "1v1Season1.subdivision.1.3",   45,  130, 10, "III"),
  ( 1, 4, "1v1Season1.subdivision.1.4",  130,  215, 10, "II"),
  ( 1, 5, "1v1Season1.subdivision.1.5",  215,  300, 10, "I"),
  ( 2, 1, "1v1Season1.subdivision.2.1",  300,  385, 10, "V"),
  ( 2, 2, "1v1Season1.subdivision.2.2",  385,  470, 10, "IV"),
  ( 2, 3, "1v1Season1.subdivision.2.3",  470,  555, 10, "III"),
  ( 2, 4, "1v1Season1.subdivision.2.4",  555,  640, 10, "II"),
  ( 2, 5, "1v1Season1.subdivision.2.5",  640,  725, 10, "I"),
  ( 3, 1, "1v1Season1.subdivision.3.1",  725,  810, 10, "V"),
  ( 3, 2, "1v1Season1.subdivision.3.2",  810,  895, 10, "IV"),
  ( 3, 3, "1v1Season1.subdivision.3.3",  895,  980, 10, "III"),
  ( 3, 4, "1v1Season1.subdivision.3.4",  980, 1065, 10, "II"),
  ( 3, 5, "1v1Season1.subdivision.3.5", 1065, 1150, 10, "I"),
  ( 4, 1, "1v1Season1.subdivision.4.1", 1150, 1235, 10, "V"),
  ( 4, 2, "1v1Season1.subdivision.4.2", 1235, 1320, 10, "IV"),
  ( 4, 3, "1v1Season1.subdivision.4.3", 1320, 1405, 10, "III"),
  ( 4, 4, "1v1Season1.subdivision.4.4", 1405, 1490, 10, "II"),
  ( 4, 5, "1v1Season1.subdivision.4.5", 1490, 1575, 10, "I"),
  ( 5, 1, "1v1Season1.subdivision.5.1", 1575, 1660, 10, "V"),
  ( 5, 2, "1v1Season1.subdivision.5.2", 1660, 1745, 10, "IV"),
  ( 5, 3, "1v1Season1.subdivision.5.3", 1745, 1830, 10, "III"),
  ( 5, 4, "1v1Season1.subdivision.5.4", 1830, 1915, 10, "II"),
  ( 5, 5, "1v1Season1.subdivision.5.5", 1915, 2000, 10, "I"),
  ( 6, 1, "1v1Season1.subdivision.6.1", 2000, 2850, 100, ""),
  ( 7, 1, "2v2Season1.subdivision.1.1", -800,  -40, 10, "V"),
  ( 7, 2, "2v2Season1.subdivision.1.2",  -40,   45, 10, "IV"),
  ( 7, 3, "2v2Season1.subdivision.1.3",   45,  130, 10, "III"),
  ( 7, 4, "2v2Season1.subdivision.1.4",  130,  215, 10, "II"),
  ( 7, 5, "2v2Season1.subdivision.1.5",  215,  300, 10, "I"),
  ( 8, 1, "2v2Season1.subdivision.2.1",  300,  385, 10, "V"),
  ( 8, 2, "2v2Season1.subdivision.2.2",  385,  470, 10, "IV"),
  ( 8, 3, "2v2Season1.subdivision.2.3",  470,  555, 10, "III"),
  ( 8, 4, "2v2Season1.subdivision.2.4",  555,  640, 10, "II"),
  ( 8, 5, "2v2Season1.subdivision.2.5",  640,  725, 10, "I"),
  ( 9, 1, "2v2Season1.subdivision.3.1",  725,  810, 10, "V"),
  ( 9, 2, "2v2Season1.subdivision.3.2",  810,  895, 10, "IV"),
  ( 9, 3, "2v2Season1.subdivision.3.3",  895,  980, 10, "III"),
  ( 9, 4, "2v2Season1.subdivision.3.4",  980, 1065, 10, "II"),
  ( 9, 5, "2v2Season1.subdivision.3.5", 1065, 1150, 10, "I"),
  (10, 1, "2v2Season1.subdivision.4.1", 1150, 1235, 10, "V"),
  (10, 2, "2v2Season1.subdivision.4.2", 1235, 1320, 10, "IV"),
  (10, 3, "2v2Season1.subdivision.4.3", 1320, 1405, 10, "III"),
  (10, 4, "2v2Season1.subdivision.4.4", 1405, 1490, 10, "II"),
  (10, 5, "2v2Season1.subdivision.4.5", 1490, 1575, 10, "I"),
  (11, 1, "2v2Season1.subdivision.5.1", 1575, 1660, 10, "V"),
  (11, 2, "2v2Season1.subdivision.5.2", 1660, 1745, 10, "IV"),
  (11, 3, "2v2Season1.subdivision.5.3", 1745, 1830, 10, "III"),
  (11, 4, "2v2Season1.subdivision.5.4", 1830, 1915, 10, "II"),
  (11, 5, "2v2Season1.subdivision.5.5", 1915, 2000, 10, "I"),
  (12, 1, "2v2Season1.subdivision.6.1", 2000, 2850, 100, "");
