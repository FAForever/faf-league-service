DELETE FROM league_season_score;
DELETE FROM league_season_division_subdivision;
DELETE FROM league_season_division;
DELETE FROM league_season;
DELETE FROM league;

INSERT INTO leaderboard (id, technical_name) VALUES
  (4, "tmm_4v4_full_share"),
  (5, "tmm_4v4_share_until_death");

INSERT INTO league (id, technical_name, name_key, description_key, image_url, medium_image_url, small_image_url) VALUES
  (1, "1v1_league", "1v1_league.name", "1v1_league.description",
  "https://content.faforever.com/divisions/icons/", "https://content.faforever.com/divisions/icons/medium/", "https://content.faforever.com/divisions/icons/small/"),
  (2, "2v2_league", "2v2_league.name", "2v2_league.description",
  "https://content.faforever.com/divisions/icons/", "https://content.faforever.com/divisions/icons/medium/", "https://content.faforever.com/divisions/icons/small/"),
  (3, "4v4_full_share_league", "4v4_fs_league.name", "4v4_fs_league.description",
  "https://content.faforever.com/divisions/icons/", "https://content.faforever.com/divisions/icons/medium/", "https://content.faforever.com/divisions/icons/small/"),
  (4, "4v4_share_until_death_league", "4v4_sud_league.name", "4v4_sud_league.description",
  "https://content.faforever.com/divisions/icons/", "https://content.faforever.com/divisions/icons/medium/", "https://content.faforever.com/divisions/icons/small/");

SET time_zone='+00:00';

INSERT INTO league_season (id, league_id, leaderboard_id, placement_games, season_number, name_key, start_date, end_date) VALUES
  (1, 1, 2, 10, 1, "1v1_season", NOW(), "2022-03-31 23:59:00"),
  (2, 2, 3, 10, 1, "2v2_season", NOW(), "2022-03-31 23:59:00"),
  (3, 3, 4, 10, 1, "4v4_fs_season", NOW(), "2022-03-31 23:59:00"),
  (4, 4, 5, 10, 1, "4v4_sud_season", NOW(), "2022-03-31 23:59:00");

INSERT INTO league_season_division (id, league_season_id, division_index, description_key, name_key) VALUES
  ( 1, 1, 1, "1v1_season_1.division.1", "bronze"),
  ( 2, 1, 2, "1v1_season_1.division.2", "silver"),
  ( 3, 1, 3, "1v1_season_1.division.3", "gold"),
  ( 4, 1, 4, "1v1_season_1.division.4", "diamond"),
  ( 5, 1, 5, "1v1_season_1.division.5", "master"),
  ( 6, 1, 6, "1v1_season_1.division.6", "grandmaster"),
  ( 7, 2, 1, "2v2_season_1.division.1", "bronze"),
  ( 8, 2, 2, "2v2_season_1.division.2", "silver"),
  ( 9, 2, 3, "2v2_season_1.division.3", "gold"),
  (10, 2, 4, "2v2_season_1.division.4", "diamond"),
  (11, 2, 5, "2v2_season_1.division.5", "master"),
  (12, 2, 6, "2v2_season_1.division.6", "grandmaster"),
  (13, 3, 1, "4v4_fs_season_1.division.1", "bronze"),
  (14, 3, 2, "4v4_fs_season_1.division.2", "silver"),
  (15, 3, 3, "4v4_fs_season_1.division.3", "gold"),
  (16, 3, 4, "4v4_fs_season_1.division.4", "diamond"),
  (17, 3, 5, "4v4_fs_season_1.division.5", "master"),
  (18, 3, 6, "4v4_fs_season_1.division.6", "grandmaster"),
  (19, 4, 1, "4v4_sud_season_1.division.1", "bronze"),
  (20, 4, 2, "4v4_sud_season_1.division.2", "silver"),
  (21, 4, 3, "4v4_sud_season_1.division.3", "gold"),
  (22, 4, 4, "4v4_sud_season_1.division.4", "diamond"),
  (23, 4, 5, "4v4_sud_season_1.division.5", "master"),
  (24, 4, 6, "4v4_sud_season_1.division.6", "grandmaster");

INSERT INTO league_season_division_subdivision (league_season_division_id, subdivision_index, description_key, min_rating, max_rating, highest_score, name_key) VALUES
  ( 1, 1, "1v1_season_1.subdivision.1.1", -800,  -40, 10, "V"),
  ( 1, 2, "1v1_season_1.subdivision.1.2",  -40,   45, 10, "IV"),
  ( 1, 3, "1v1_season_1.subdivision.1.3",   45,  130, 10, "III"),
  ( 1, 4, "1v1_season_1.subdivision.1.4",  130,  215, 10, "II"),
  ( 1, 5, "1v1_season_1.subdivision.1.5",  215,  300, 10, "I"),
  ( 2, 1, "1v1_season_1.subdivision.2.1",  300,  385, 10, "V"),
  ( 2, 2, "1v1_season_1.subdivision.2.2",  385,  470, 10, "IV"),
  ( 2, 3, "1v1_season_1.subdivision.2.3",  470,  555, 10, "III"),
  ( 2, 4, "1v1_season_1.subdivision.2.4",  555,  640, 10, "II"),
  ( 2, 5, "1v1_season_1.subdivision.2.5",  640,  725, 10, "I"),
  ( 3, 1, "1v1_season_1.subdivision.3.1",  725,  810, 10, "V"),
  ( 3, 2, "1v1_season_1.subdivision.3.2",  810,  895, 10, "IV"),
  ( 3, 3, "1v1_season_1.subdivision.3.3",  895,  980, 10, "III"),
  ( 3, 4, "1v1_season_1.subdivision.3.4",  980, 1065, 10, "II"),
  ( 3, 5, "1v1_season_1.subdivision.3.5", 1065, 1150, 10, "I"),
  ( 4, 1, "1v1_season_1.subdivision.4.1", 1150, 1235, 10, "V"),
  ( 4, 2, "1v1_season_1.subdivision.4.2", 1235, 1320, 10, "IV"),
  ( 4, 3, "1v1_season_1.subdivision.4.3", 1320, 1405, 10, "III"),
  ( 4, 4, "1v1_season_1.subdivision.4.4", 1405, 1490, 10, "II"),
  ( 4, 5, "1v1_season_1.subdivision.4.5", 1490, 1575, 10, "I"),
  ( 5, 1, "1v1_season_1.subdivision.5.1", 1575, 1660, 10, "V"),
  ( 5, 2, "1v1_season_1.subdivision.5.2", 1660, 1745, 10, "IV"),
  ( 5, 3, "1v1_season_1.subdivision.5.3", 1745, 1830, 10, "III"),
  ( 5, 4, "1v1_season_1.subdivision.5.4", 1830, 1915, 10, "II"),
  ( 5, 5, "1v1_season_1.subdivision.5.5", 1915, 2000, 10, "I"),
  ( 6, 1, "1v1_season_1.subdivision.6.1", 2000, 2850, 100, ""),
  ( 7, 1, "2v2_season_1.subdivision.1.1", -800,  -40, 10, "V"),
  ( 7, 2, "2v2_season_1.subdivision.1.2",  -40,   45, 10, "IV"),
  ( 7, 3, "2v2_season_1.subdivision.1.3",   45,  130, 10, "III"),
  ( 7, 4, "2v2_season_1.subdivision.1.4",  130,  215, 10, "II"),
  ( 7, 5, "2v2_season_1.subdivision.1.5",  215,  300, 10, "I"),
  ( 8, 1, "2v2_season_1.subdivision.2.1",  300,  385, 10, "V"),
  ( 8, 2, "2v2_season_1.subdivision.2.2",  385,  470, 10, "IV"),
  ( 8, 3, "2v2_season_1.subdivision.2.3",  470,  555, 10, "III"),
  ( 8, 4, "2v2_season_1.subdivision.2.4",  555,  640, 10, "II"),
  ( 8, 5, "2v2_season_1.subdivision.2.5",  640,  725, 10, "I"),
  ( 9, 1, "2v2_season_1.subdivision.3.1",  725,  810, 10, "V"),
  ( 9, 2, "2v2_season_1.subdivision.3.2",  810,  895, 10, "IV"),
  ( 9, 3, "2v2_season_1.subdivision.3.3",  895,  980, 10, "III"),
  ( 9, 4, "2v2_season_1.subdivision.3.4",  980, 1065, 10, "II"),
  ( 9, 5, "2v2_season_1.subdivision.3.5", 1065, 1150, 10, "I"),
  (10, 1, "2v2_season_1.subdivision.4.1", 1150, 1235, 10, "V"),
  (10, 2, "2v2_season_1.subdivision.4.2", 1235, 1320, 10, "IV"),
  (10, 3, "2v2_season_1.subdivision.4.3", 1320, 1405, 10, "III"),
  (10, 4, "2v2_season_1.subdivision.4.4", 1405, 1490, 10, "II"),
  (10, 5, "2v2_season_1.subdivision.4.5", 1490, 1575, 10, "I"),
  (11, 1, "2v2_season_1.subdivision.5.1", 1575, 1660, 10, "V"),
  (11, 2, "2v2_season_1.subdivision.5.2", 1660, 1745, 10, "IV"),
  (11, 3, "2v2_season_1.subdivision.5.3", 1745, 1830, 10, "III"),
  (11, 4, "2v2_season_1.subdivision.5.4", 1830, 1915, 10, "II"),
  (11, 5, "2v2_season_1.subdivision.5.5", 1915, 2000, 10, "I"),
  (12, 1, "2v2_season_1.subdivision.6.1", 2000, 2850, 100, ""),
  (13, 1, "4v4_fs_season_1.subdivision.1.1", -800,  -40, 10, "V"),
  (13, 2, "4v4_fs_season_1.subdivision.1.2",  -40,   45, 10, "IV"),
  (13, 3, "4v4_fs_season_1.subdivision.1.3",   45,  130, 10, "III"),
  (13, 4, "4v4_fs_season_1.subdivision.1.4",  130,  215, 10, "II"),
  (13, 5, "4v4_fs_season_1.subdivision.1.5",  215,  300, 10, "I"),
  (14, 1, "4v4_fs_season_1.subdivision.2.1",  300,  385, 10, "V"),
  (14, 2, "4v4_fs_season_1.subdivision.2.2",  385,  470, 10, "IV"),
  (14, 3, "4v4_fs_season_1.subdivision.2.3",  470,  555, 10, "III"),
  (14, 4, "4v4_fs_season_1.subdivision.2.4",  555,  640, 10, "II"),
  (14, 5, "4v4_fs_season_1.subdivision.2.5",  640,  725, 10, "I"),
  (15, 1, "4v4_fs_season_1.subdivision.3.1",  725,  810, 10, "V"),
  (15, 2, "4v4_fs_season_1.subdivision.3.2",  810,  895, 10, "IV"),
  (15, 3, "4v4_fs_season_1.subdivision.3.3",  895,  980, 10, "III"),
  (15, 4, "4v4_fs_season_1.subdivision.3.4",  980, 1065, 10, "II"),
  (15, 5, "4v4_fs_season_1.subdivision.3.5", 1065, 1150, 10, "I"),
  (16, 1, "4v4_fs_season_1.subdivision.4.1", 1150, 1235, 10, "V"),
  (16, 2, "4v4_fs_season_1.subdivision.4.2", 1235, 1320, 10, "IV"),
  (16, 3, "4v4_fs_season_1.subdivision.4.3", 1320, 1405, 10, "III"),
  (16, 4, "4v4_fs_season_1.subdivision.4.4", 1405, 1490, 10, "II"),
  (16, 5, "4v4_fs_season_1.subdivision.4.5", 1490, 1575, 10, "I"),
  (17, 1, "4v4_fs_season_1.subdivision.5.1", 1575, 1660, 10, "V"),
  (17, 2, "4v4_fs_season_1.subdivision.5.2", 1660, 1745, 10, "IV"),
  (17, 3, "4v4_fs_season_1.subdivision.5.3", 1745, 1830, 10, "III"),
  (17, 4, "4v4_fs_season_1.subdivision.5.4", 1830, 1915, 10, "II"),
  (17, 5, "4v4_fs_season_1.subdivision.5.5", 1915, 2000, 10, "I"),
  (18, 1, "4v4_fs_season_1.subdivision.6.1", 2000, 2850, 100, ""),
  (19, 1, "4v4_sud_season_1.subdivision.1.1", -800,  -40, 10, "V"),
  (19, 2, "4v4_sud_season_1.subdivision.1.2",  -40,   45, 10, "IV"),
  (19, 3, "4v4_sud_season_1.subdivision.1.3",   45,  130, 10, "III"),
  (19, 4, "4v4_sud_season_1.subdivision.1.4",  130,  215, 10, "II"),
  (19, 5, "4v4_sud_season_1.subdivision.1.5",  215,  300, 10, "I"),
  (20, 1, "4v4_sud_season_1.subdivision.2.1",  300,  385, 10, "V"),
  (20, 2, "4v4_sud_season_1.subdivision.2.2",  385,  470, 10, "IV"),
  (20, 3, "4v4_sud_season_1.subdivision.2.3",  470,  555, 10, "III"),
  (20, 4, "4v4_sud_season_1.subdivision.2.4",  555,  640, 10, "II"),
  (20, 5, "4v4_sud_season_1.subdivision.2.5",  640,  725, 10, "I"),
  (21, 1, "4v4_sud_season_1.subdivision.3.1",  725,  810, 10, "V"),
  (21, 2, "4v4_sud_season_1.subdivision.3.2",  810,  895, 10, "IV"),
  (21, 3, "4v4_sud_season_1.subdivision.3.3",  895,  980, 10, "III"),
  (21, 4, "4v4_sud_season_1.subdivision.3.4",  980, 1065, 10, "II"),
  (21, 5, "4v4_sud_season_1.subdivision.3.5", 1065, 1150, 10, "I"),
  (22, 1, "4v4_sud_season_1.subdivision.4.1", 1150, 1235, 10, "V"),
  (22, 2, "4v4_sud_season_1.subdivision.4.2", 1235, 1320, 10, "IV"),
  (22, 3, "4v4_sud_season_1.subdivision.4.3", 1320, 1405, 10, "III"),
  (22, 4, "4v4_sud_season_1.subdivision.4.4", 1405, 1490, 10, "II"),
  (22, 5, "4v4_sud_season_1.subdivision.4.5", 1490, 1575, 10, "I"),
  (23, 1, "4v4_sud_season_1.subdivision.5.1", 1575, 1660, 10, "V"),
  (23, 2, "4v4_sud_season_1.subdivision.5.2", 1660, 1745, 10, "IV"),
  (23, 3, "4v4_sud_season_1.subdivision.5.3", 1745, 1830, 10, "III"),
  (23, 4, "4v4_sud_season_1.subdivision.5.4", 1830, 1915, 10, "II"),
  (23, 5, "4v4_sud_season_1.subdivision.5.5", 1915, 2000, 10, "I"),
  (24, 1, "4v4_sud_season_1.subdivision.6.1", 2000, 2850, 100, "");