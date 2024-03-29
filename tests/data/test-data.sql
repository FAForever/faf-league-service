-- DUMMY DATA ONLY, FOR USE IN UNIT TESTS

SET FOREIGN_KEY_CHECKS=0;

DELETE FROM leaderboard;
DELETE FROM league_season_score;
DELETE FROM league_season_division_subdivision;
DELETE FROM league_season_division;
DELETE FROM league_season;
DELETE FROM league;

SET FOREIGN_KEY_CHECKS=1;

insert into leaderboard (id, technical_name) values
  (1, "global"),
  (2, "ladder_1v1"),
  (3, "tmm_2v2"),
  (4, "tmm_4v4");

INSERT INTO league (id, technical_name, enabled, image_url, medium_image_url, small_image_url, name_key, description_key) VALUES
  (1, "test_league", TRUE, "https://faf.com/", "https://faf.com/medium/", "https://faf.com/small/", "L1", "description_key"),
  (2, "second_test_league", TRUE,  "https://faf.com/", "https://faf.com/medium/", "https://faf.com/small/", "L2", "description_key"),
  (3, "league_without_seasons", TRUE, "https://faf.com/", "https://faf.com/medium/", "https://faf.com/small/", "L3", "description_key");

INSERT INTO league_season (id, league_id, leaderboard_id, placement_games, placement_games_returning_player, season_number, name_key, start_date, end_date) VALUES
  (1, 1, 1, 10, 3, 1, "test_league.season.1", NOW() - interval 2 week, NOW() - interval 1 week),
  (2, 1, 1, 10, 3, 2, "test_league.season.2", NOW() - interval 1 week, NOW() + interval 1 week),
  (3, 2, 2, 10, 3, 1, "second_test_league.season.1", NOW() - interval 2 week, NOW() + interval 1 week),
  (4, 1, 1, 10, 3, 3, "test_league.season.3", NOW() + interval 1 week, NOW() + interval 2 week);

INSERT INTO league_season_division (id, league_season_id, division_index, name_key, description_key) VALUES
  (1, 1, 1, "L1D1", "description_key"),
  (2, 1, 2, "L1D2", "description_key"),
  (3, 2, 1, "L2D1", "description_key"),
  (4, 2, 2, "L2D2", "description_key"),
  (5, 2, 3, "L2D3", "description_key"),
  (6, 3, 1, "L3D1", "description_key"),
  (7, 3, 2, "L3D2", "description_key");

INSERT INTO league_season_division_subdivision (id, league_season_division_id, subdivision_index, name_key, description_key, min_rating, max_rating, highest_score) VALUES
  (1, 1, 1, "L1D1S1", "description_key", 0, 150, 10),
  (2, 2, 1, "L1D2S1", "description_key", 150, 3000, 10),
  (3, 3, 1, "L2D1S1", "description_key", 0, 100, 10),
  (4, 3, 2, "L2D1S2", "description_key", 100, 200, 10),
  (5, 4, 1, "L2D2S1", "description_key", 200, 300, 10),
  (6, 4, 2, "L2D2S2", "description_key", 300, 400, 10),
  (7, 5, 1, "L2D3S1", "description_key", 400, 500, 10),
  (8, 5, 2, "L2D3S2", "description_key", 500, 600, 100),
  (9, 6, 1, "L3D1S1", "description_key", 0, 3000, 20);

INSERT INTO league_season_score (login_id, league_season_id, subdivision_id, score, game_count, returning_player) VALUES
  (1, 1, 1, 5, 5, FALSE),
  (1, 2, 5, 3, 15, TRUE),
  (1, 3, 9, 1200, 120, FALSE),
  (2, 1, 2, 0, 15, FALSE),
  (3, 2, 8, 5, 5, FALSE);
