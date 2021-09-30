SET time_zone='+00:00';

UPDATE league_season SET end_date = "2021-10-31 23:59:00" WHERE end_date IS NULL;

ALTER TABLE league_season MODIFY COLUMN end_date DATETIME NOT NULL;