SET time_zone='+00:00';

SET @Seasonnumber = 6;

INSERT INTO leaderboard (id, technical_name) VALUES
  (6, "tmm_3v3");

INSERT INTO league (id, technical_name, enabled, name_key, description_key, image_url, medium_image_url, small_image_url) VALUES
  (5, "3v3_league", TRUE, "3v3_league.name", "3v3_league.description",
  "https://content.faforever.com/divisions/icons/", "https://content.faforever.com/divisions/icons/medium/", "https://content.faforever.com/divisions/icons/small/");

-- season starts and ends at noon, so that all timezones see the same date in the client
INSERT INTO league_season (id, league_id, leaderboard_id, placement_games, placement_games_returning_player, season_number, name_key, start_date, end_date) VALUES
  (21, 5, 6, 10, 3, @Seasonnumber, "3v3_season", TIMESTAMP(CURRENT_DATE, "12:00:00"), TIMESTAMP("2023-06-30", "12:00:00"));

INSERT INTO league_season_division (id, league_season_id, division_index, description_key, name_key) VALUES
  (120 +  1, 21, 1, CONCAT("3v3_season_", @Seasonnumber, ".division.1"), "bronze"),
  (120 +  2, 21, 2, CONCAT("3v3_season_", @Seasonnumber, ".division.2"), "silver"),
  (120 +  3, 21, 3, CONCAT("3v3_season_", @Seasonnumber, ".division.3"), "gold"),
  (120 +  4, 21, 4, CONCAT("3v3_season_", @Seasonnumber, ".division.4"), "diamond"),
  (120 +  5, 21, 5, CONCAT("3v3_season_", @Seasonnumber, ".division.5"), "master"),
  (120 +  6, 21, 6, CONCAT("3v3_season_", @Seasonnumber, ".division.6"), "grandmaster");

INSERT INTO league_season_division_subdivision (league_season_division_id, subdivision_index, description_key, min_rating, max_rating, highest_score, name_key) VALUES
  (120 +  1, 1, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.1.1"), -800,  -40, 10, "V"),
  (120 +  1, 2, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.1.2"),  -40,   45, 10, "IV"),
  (120 +  1, 3, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.1.3"),   45,  130, 10, "III"),
  (120 +  1, 4, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.1.4"),  130,  215, 10, "II"),
  (120 +  1, 5, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.1.5"),  215,  300, 10, "I"),
  (120 +  2, 1, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.2.1"),  300,  385, 10, "V"),
  (120 +  2, 2, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.2.2"),  385,  470, 10, "IV"),
  (120 +  2, 3, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.2.3"),  470,  555, 10, "III"),
  (120 +  2, 4, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.2.4"),  555,  640, 10, "II"),
  (120 +  2, 5, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.2.5"),  640,  725, 10, "I"),
  (120 +  3, 1, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.3.1"),  725,  810, 10, "V"),
  (120 +  3, 2, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.3.2"),  810,  895, 10, "IV"),
  (120 +  3, 3, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.3.3"),  895,  980, 10, "III"),
  (120 +  3, 4, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.3.4"),  980, 1065, 10, "II"),
  (120 +  3, 5, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.3.5"), 1065, 1150, 10, "I"),
  (120 +  4, 1, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.4.1"), 1150, 1235, 10, "V"),
  (120 +  4, 2, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.4.2"), 1235, 1320, 10, "IV"),
  (120 +  4, 3, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.4.3"), 1320, 1405, 10, "III"),
  (120 +  4, 4, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.4.4"), 1405, 1490, 10, "II"),
  (120 +  4, 5, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.4.5"), 1490, 1575, 10, "I"),
  (120 +  5, 1, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.5.1"), 1575, 1660, 10, "V"),
  (120 +  5, 2, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.5.2"), 1660, 1745, 10, "IV"),
  (120 +  5, 3, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.5.3"), 1745, 1830, 10, "III"),
  (120 +  5, 4, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.5.4"), 1830, 1915, 10, "II"),
  (120 +  5, 5, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.5.5"), 1915, 2000, 10, "I"),
  (120 +  6, 1, CONCAT("3v3_season_", @Seasonnumber, ".subdivision.6.1"), 2000, 2850, 100, "");