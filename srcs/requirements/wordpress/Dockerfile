FROM debian:buster
EXPOSE 9000

# Update and upgrade packages, then install packages
RUN apt-get update && apt-get upgrade -y \
     && apt-get install -y \
     php7.3-mysql \
     php7.3-fpm \
     mariadb-client \
     curl

# Install wp-cli, a command line interface for WordPress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
     && chmod +x wp-cli.phar \
     && mv wp-cli.phar /usr/local/bin/wp-cli.phar

# Create a directory for the PHP-FPM socket
RUN mkdir -p /run/php

# Configure PHP-FPM to listen on wordpress:9000
RUN sed -i "s/listen.*/listen = wordpress:9000/" /etc/php/7.3/fpm/pool.d/www.conf

# Copy the initialization script for WordPress
COPY tools/init_wp.sh /var/www/
RUN chmod +x /var/www/init_wp.sh

# Set the entrypoint to the initialization script
ENTRYPOINT [ "/var/www/init_wp.sh" ]

# Start PHP-FPM in foreground mode which is given to the entrypoint
CMD [ "php-fpm7.3", "-R", "-F" ]
