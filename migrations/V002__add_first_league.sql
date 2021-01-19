INSERT INTO leaderboard (id, technical_name) VALUES
  (1, "global"),
  (2, "ladder_1v1");

INSERT INTO league (id, technical_name, name_key, description_key) VALUES
  (1, "GlobalLeague", "GlobalLeague", "GlobalLeagueDescription"),
  (2, "LadderLeague", "LadderLeague", "LadderLeagueDescription");

INSERT INTO league_season (id, league_id, leaderboard_id, start_date, end_date) VALUES
  (1, 1, 1, NOW(), NULL),
  (2, 2, 2, NOW(), NULL);

INSERT INTO league_season_division (id, league_season_id, division_index, name_key, description_key) VALUES
  (1, 1, 1, "GlobalLeagueDivision1", "GlobalLeagueDivision1Description"),
  (2, 1, 2, "GlobalLeagueDivision2", "GlobalLeagueDivision2Description"),
  (3, 1, 3, "GlobalLeagueDivision3", "GlobalLeagueDivision3Description"),
  (4, 1, 4, "GlobalLeagueDivision4", "GlobalLeagueDivision4Description"),
  (5, 1, 5, "GlobalLeagueDivision5", "GlobalLeagueDivision5Description"),
  (6, 1, 6, "GlobalLeagueDivision6", "GlobalLeagueDivision6Description"),
  (7, 2, 1, "LadderLeagueDivision1", "LadderLeagueDivision1Description"),
  (8, 2, 2, "LadderLeagueDivision2", "LadderLeagueDivision2Description"),
  (9, 2, 3, "LadderLeagueDivision3", "LadderLeagueDivision3Description"),
  (10, 2, 4, "LadderLeagueDivision4", "LadderLeagueDivision4Description"),
  (11, 2, 5, "LadderLeagueDivision5", "LadderLeagueDivision5Description"),
  (12, 2, 6, "LadderLeagueDivision6", "LadderLeagueDivision6Description");

INSERT INTO league_season_division_subdivision (league_season_division_id, subdivision_index, name_key, description_key, min_rating, max_rating, highest_score) VALUES
  (1, 1, "GlobalLeagueSubdivision1.1", "GlobalLeagueSubdivision1.1Description", -1000, -600, 10),
  (1, 2, "GlobalLeagueSubdivision1.2", "GlobalLeagueSubdivision1.2Description", -600, -500, 10),
  (1, 3, "GlobalLeagueSubdivision1.3", "GlobalLeagueSubdivision1.3Description", -500, -400, 10),
  (1, 4, "GlobalLeagueSubdivision1.4", "GlobalLeagueSubdivision1.4Description", -400, -300, 10),
  (1, 5, "GlobalLeagueSubdivision1.5", "GlobalLeagueSubdivision1.5Description", -300, -200, 10),
  (2, 1, "GlobalLeagueSubdivision2.1", "GlobalLeagueSubdivision2.1Description", -200, -100, 10),
  (2, 2, "GlobalLeagueSubdivision2.2", "GlobalLeagueSubdivision2.2Description", -100, -0, 10),
  (2, 3, "GlobalLeagueSubdivision2.3", "GlobalLeagueSubdivision2.3Description", 0, 100, 10),
  (2, 4, "GlobalLeagueSubdivision2.4", "GlobalLeagueSubdivision2.4Description", 100, 200, 10),
  (2, 5, "GlobalLeagueSubdivision2.5", "GlobalLeagueSubdivision2.5Description", 200, 300, 10),
  (3, 1, "GlobalLeagueSubdivision3.1", "GlobalLeagueSubdivision3.1Description", 300, 400, 10),
  (3, 2, "GlobalLeagueSubdivision3.2", "GlobalLeagueSubdivision3.2Description", 400, 500, 10),
  (3, 3, "GlobalLeagueSubdivision3.3", "GlobalLeagueSubdivision3.3Description", 500, 600, 10),
  (3, 4, "GlobalLeagueSubdivision3.4", "GlobalLeagueSubdivision3.4Description", 600, 700, 10),
  (3, 5, "GlobalLeagueSubdivision3.5", "GlobalLeagueSubdivision3.5Description", 700, 800, 10),
  (4, 1, "GlobalLeagueSubdivision4.1", "GlobalLeagueSubdivision4.1Description", 800, 900, 10),
  (4, 2, "GlobalLeagueSubdivision4.2", "GlobalLeagueSubdivision4.2Description", 900, 1000, 10),
  (4, 3, "GlobalLeagueSubdivision4.3", "GlobalLeagueSubdivision4.3Description", 1000, 1100, 10),
  (4, 4, "GlobalLeagueSubdivision4.4", "GlobalLeagueSubdivision4.4Description", 1100, 1200, 10),
  (4, 5, "GlobalLeagueSubdivision4.5", "GlobalLeagueSubdivision4.5Description", 1200, 1300, 10),
  (5, 1, "GlobalLeagueSubdivision5.1", "GlobalLeagueSubdivision5.1Description", 1300, 1400, 10),
  (5, 2, "GlobalLeagueSubdivision5.2", "GlobalLeagueSubdivision5.2Description", 1400, 1500, 10),
  (5, 3, "GlobalLeagueSubdivision5.3", "GlobalLeagueSubdivision5.3Description", 1500, 1600, 10),
  (5, 4, "GlobalLeagueSubdivision5.4", "GlobalLeagueSubdivision5.4Description", 1600, 1700, 10),
  (5, 5, "GlobalLeagueSubdivision5.5", "GlobalLeagueSubdivision5.5Description", 1700, 1800, 10),
  (6, 1, "GlobalLeagueSubdivision6.1", "GlobalLeagueSubdivision6.1Description", 1800, 3000, 100),
  (7, 1, "LadderLeagueSubdivision1.1", "LadderLeagueSubdivision1.1Description", -1000, -600, 10),
  (7, 2, "LadderLeagueSubdivision1.2", "LadderLeagueSubdivision1.2Description", -600, -500, 10),
  (7, 3, "LadderLeagueSubdivision1.3", "LadderLeagueSubdivision1.3Description", -500, -400, 10),
  (7, 4, "LadderLeagueSubdivision1.4", "LadderLeagueSubdivision1.4Description", -400, -300, 10),
  (7, 5, "LadderLeagueSubdivision1.5", "LadderLeagueSubdivision1.5Description", -300, -200, 10),
  (8, 1, "LadderLeagueSubdivision2.1", "LadderLeagueSubdivision2.1Description", -200, -100, 10),
  (8, 2, "LadderLeagueSubdivision2.2", "LadderLeagueSubdivision2.2Description", -100, -0, 10),
  (8, 3, "LadderLeagueSubdivision2.3", "LadderLeagueSubdivision2.3Description", 0, 100, 10),
  (8, 4, "LadderLeagueSubdivision2.4", "LadderLeagueSubdivision2.4Description", 100, 200, 10),
  (8, 5, "LadderLeagueSubdivision2.5", "LadderLeagueSubdivision2.5Description", 200, 300, 10),
  (9, 1, "LadderLeagueSubdivision3.1", "LadderLeagueSubdivision3.1Description", 300, 400, 10),
  (9, 2, "LadderLeagueSubdivision3.2", "LadderLeagueSubdivision3.2Description", 400, 500, 10),
  (9, 3, "LadderLeagueSubdivision3.3", "LadderLeagueSubdivision3.3Description", 500, 600, 10),
  (9, 4, "LadderLeagueSubdivision3.4", "LadderLeagueSubdivision3.4Description", 600, 700, 10),
  (9, 5, "LadderLeagueSubdivision3.5", "LadderLeagueSubdivision3.5Description", 700, 800, 10),
  (10, 1, "LadderLeagueSubdivision4.1", "LadderLeagueSubdivision4.1Description", 800, 900, 10),
  (10, 2, "LadderLeagueSubdivision4.2", "LadderLeagueSubdivision4.2Description", 900, 1000, 10),
  (10, 3, "LadderLeagueSubdivision4.3", "LadderLeagueSubdivision4.3Description", 1000, 1100, 10),
  (10, 4, "LadderLeagueSubdivision4.4", "LadderLeagueSubdivision4.4Description", 1100, 1200, 10),
  (10, 5, "LadderLeagueSubdivision4.5", "LadderLeagueSubdivision4.5Description", 1200, 1300, 10),
  (11, 1, "LadderLeagueSubdivision5.1", "LadderLeagueSubdivision5.1Description", 1300, 1400, 10),
  (11, 2, "LadderLeagueSubdivision5.2", "LadderLeagueSubdivision5.2Description", 1400, 1500, 10),
  (11, 3, "LadderLeagueSubdivision5.3", "LadderLeagueSubdivision5.3Description", 1500, 1600, 10),
  (11, 4, "LadderLeagueSubdivision5.4", "LadderLeagueSubdivision5.4Description", 1600, 1700, 10),
  (11, 5, "LadderLeagueSubdivision5.5", "LadderLeagueSubdivision5.5Description", 1700, 1800, 10),
  (12, 1, "LadderLeagueSubdivision6.1", "LadderLeagueSubdivision6.1Description", 1800, 3000, 100);