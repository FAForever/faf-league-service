DROP TABLE league_season_score;

CREATE TABLE league_season_score
(
    id               INT(10) UNSIGNED      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login_id         MEDIUMINT(8) UNSIGNED NOT NULL,
    league_season_id MEDIUMINT(8) UNSIGNED NOT NULL,
    subdivision_id   INT(10) UNSIGNED,
    score            INT,
    game_count       INT NOT NULL DEFAULT 0,
    FOREIGN KEY (subdivision_id) REFERENCES league_season_division_subdivision (id),
    UNIQUE INDEX (login_id, score, league_season_id)
);