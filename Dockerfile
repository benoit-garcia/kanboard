FROM        nginx:1.9
MAINTAINER  Benoit <benoit@terra-art.net>

# Set Environement variables
ENV         LC_ALL=C
ENV         DEBIAN_FRONTEND=noninteractive
ENV         KANBOARD_VERSION=1.0.16
# Update package repository and install packages
RUN         apt-get -y update && \
            apt-get -y install \
             php5-fpm \
             php5-sqlite \
             supervisor \
             unzip \
             wget

# Fetch the latest software version from the official website if needed
RUN         test ! -d /usr/share/nginx/html/kanboard && \
            wget http://kanboard.net/kanboard-${KANBOARD_VERSION}.zip && \
            unzip kanboard-${KANBOARD_VERSION}.zip -d /usr/share/nginx/html/ && \
            chown -R www-data:www-data /usr/share/nginx/html/kanboard/data && \
            rm kanboard-${KANBOARD_VERSION}.zip

# Add configuration files. User can provides customs files using -v in the image startup command line.
COPY        supervisord.conf /etc/supervisor/supervisord.conf
COPY        nginx.conf /etc/nginx/nginx.conf
COPY        php-fpm.conf /etc/php5/fpm/php-fpm.conf

# Expose HTTP port
EXPOSE      80

# Last but least, unleach the daemon!
ENTRYPOINT   ["/usr/bin/supervisord"]
