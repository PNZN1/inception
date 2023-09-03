#!/bin/bash

echo "init_wp.sh -> downloading and setting up"
wp-cli.phar core download --path="/var/www/html" --allow-root

wp-cli.phar config create --path="/var/www/html" \
                 --dbname="$DB_NAME" \
                 --dbuser="$DB_USER" \
                 --dbpass="$DB_PASS" \
                 --dbhost="$DB_HOST" \
                 --allow-root

echo "init_wp.sh -> installing WordPress"
wp-cli.phar core install --path="/var/www/html" \
                --title="pniezen - wordpress" \
                --admin_user="$WP_ADMIN_NAME" \
                --admin_password="$WP_ADMIN_PASS" \
                --admin_email="admin@example.com" \
                --skip-email \
                --url="https://pniezen.42.fr/" \
                --allow-root

echo "init_wp.sh -> creating regular user"
wp-cli.phar user create "$WP_USER_NAME" user@example.com \
                --path="/var/www/html" \
                --user_pass="$WP_USER_PASS" \
                --allow-root

exec "$@"
