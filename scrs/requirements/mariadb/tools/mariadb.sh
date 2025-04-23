#!/bin/sh

set -e

# Initialise la base de données MariaDB si ce n'est pas déjà fait
mysql_install_db > /dev/null

# Démarre le service MariaDB temporairement
/etc/init.d/mysql start

# Vérifie si la base existe déjà
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "✅ Database $MYSQL_DATABASE already exists."
else
    echo "🚀 Initializing new database..."

    # Crée la base de données et l'utilisateur WordPress
    mysql -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
    mysql -e "FLUSH PRIVILEGES;"

    # Importe le fichier .sql de WordPress (si présent)
    if [ -f /usr/local/bin/wordpress.sql ]; then
        echo "📥 Importing wordpress.sql..."
        mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /usr/local/bin/wordpress.sql
    else
        echo "⚠️  wordpress.sql not found, skipping import."
    fi
fi

# Stoppe MariaDB proprement
/etc/init.d/mysql stop

# Démarre le conteneur avec la commande passée à CMD
exec "$@"
