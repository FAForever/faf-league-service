ALTER table league
ADD COLUMN `enabled` BOOLEAN NOT NULL DEFAULT TRUE AFTER technical_name;
UPDATE league SET enabled = TRUE;