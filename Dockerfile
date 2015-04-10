FROM        nginx:latest
MAINTAINER  Benoit <benoit@terra-art.net>

# Set Environement variables
ENV         LC_ALL=C
ENV         DEBIAN_FRONTEND=noninteractive
ENV         KANBOARD_VERSION=1.0.13
ENV         PHP_VERSION=5.4.39-0+deb7u2
ENV         SUPERVISOR_VERSION=3.0a8-1.1+deb7u1
# Update package repository and install packages
RUN         apt-get -y update && \
            apt-get -y install supervisor=${SUPERVISOR_VERSION} php5-fpm=${PHP_VERSION} php5-sqlite=${PHP_VERSION} wget && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fetch the latest software version from the official website if needed
RUN         test ! -d /usr/share/nginx/html/kanboard-${KANBOARD_VERSION} && \
            wget https://github.com/fguillot/kanboard/archive/v${KANBOARD_VERSION}.tar.gz && \
            tar xvzf v${KANBOARD_VERSION}.tar.gz -C /usr/share/nginx/html &&
            mv /usr/share/nginx/html/kanboard-${KANBOARD_VERSION} /usr/sgare/nginx/html/kanboard && \
            chown -R www-data:www-data /usr/share/nginx/html/kanboard/data && \
            rm v${KANBOARD_VERSION}.tar.gz

# Add configuration files. User can provides customs files using -v in the image startup command line.
COPY        supervisord.conf /etc/supervisor/supervisord.conf
COPY        nginx.conf /etc/nginx/nginx.conf
COPY        php-fpm.conf /etc/php5/fpm/php-fpm.conf

# Expose HTTP port
EXPOSE      80

# Last but least, unleach the daemon!
ENTRYPOINT   ["/usr/bin/supervisord"]
