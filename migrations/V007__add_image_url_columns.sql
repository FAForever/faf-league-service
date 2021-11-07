ALTER table league
ADD COLUMN image_url VARCHAR(255) NOT NULL AFTER technical_name,
ADD COLUMN medium_image_url VARCHAR(255) NOT NULL AFTER image_url,
ADD COLUMN small_image_url VARCHAR(255) NOT NULL AFTER medium_image_url;

UPDATE league SET image_url = "https://content.faforever.com/divisions/icons/";
UPDATE league SET medium_image_url = "https://content.faforever.com/divisions/icons/medium/";
UPDATE league SET small_image_url = "https://content.faforever.com/divisions/icons/small/";