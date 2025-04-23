-- Création de la base de données WordPress
CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Création de l'utilisateur WordPress
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_password';

-- Attribution des droits à l'utilisateur sur la base WordPress
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';

-- Appliquer les privilèges immédiatement
FLUSH PRIVILEGES;
