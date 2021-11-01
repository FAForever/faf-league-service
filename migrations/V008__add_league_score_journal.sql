CREATE TABLE league_score_journal
(
    id               INT(10) UNSIGNED      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login_id         MEDIUMINT(8) UNSIGNED NOT NULL,
    league_season_id MEDIUMINT(8) UNSIGNED NOT NULL,
    subdivision_id_before  INT(10) UNSIGNED,
    subdivision_id_after   INT(10) UNSIGNED,
    score_before           INT,
    score_after            INT,
    game_count             INT NOT NULL DEFAULT 0,
    FOREIGN KEY (league_season_id) REFERENCES league_season (id),
    FOREIGN KEY (subdivision_id_before) REFERENCES league_season_division_subdivision (id),
    FOREIGN KEY (subdivision_id_after) REFERENCES league_season_division_subdivision (id)
);