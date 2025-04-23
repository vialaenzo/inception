#!/bin/sh

cd /var/www/html

echo "Waiting for MariaDB..."
until mysqladmin ping -h"$MYSQL_HOSTNAME" --silent; do
	sleep 1
done

if [ -f wp-config.php ]; then
	echo "WordPress already installed"
else
	echo "Downloading WordPress..."
	wget http://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz wordpress

	echo "Configuring wp-config.php..."
	sed -i "s|database_name_here|$MYSQL_DATABASE|" wp-config-sample.php
	sed -i "s|username_here|$MYSQL_USER|" wp-config-sample.php
	sed -i "s|password_here|$MYSQL_PASSWORD|" wp-config-sample.php
	sed -i "s|localhost|$MYSQL_HOSTNAME|" wp-config-sample.php

	# Remove all old salt keys
	sed -i '/AUTH_KEY\|SECURE_AUTH_KEY\|LOGGED_IN_KEY\|NONCE_KEY\|AUTH_SALT\|SECURE_AUTH_SALT\|LOGGED_IN_SALT\|NONCE_SALT/d' wp-config-sample.php

	echo "Adding new security salts..."
	SALT=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
	echo "$SALT" >> wp-config-sample.php

	cp wp-config-sample.php wp-config.php
	chown -R www-data:www-data /var/www/html
fi

exec "$@"
