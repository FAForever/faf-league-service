ALTER table league
ADD COLUMN image_key VARCHAR(255) NOT NULL AFTER technical_name,
ADD COLUMN medium_image_key VARCHAR(255) NOT NULL AFTER image_key,
ADD COLUMN small_image_key VARCHAR(255) NOT NULL AFTER medium_image_key;

UPDATE league SET image_key = "https://content.faforever.com/divisions/icons/";
UPDATE league SET medium_image_key = "https://content.faforever.com/divisions/icons/medium/";
UPDATE league SET small_image_key = "https://content.faforever.com/divisions/icons/small/";