FROM        nginx:latest
MAINTAINER  Benoit <benoit@terra-art.net>

# Expose HTTP port
EXPOSE      80

# Update package repository and install packages
RUN         LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get -y update && \
            LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get -y install php5-fpm php5-sqlite wget unzip && \
            LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get clean && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fetch the latest software version from the official website
RUN         wget http://kanboard.net/kanboard-latest.zip && \
            unzip kanboard-latest.zip -d /usr/share/nginx/html && \
            chown -R www-data:www-data /usr/share/nginx/html/kanboard/data && \
            rm kanboard-latest.zip

# Add configuration files. User can provides customs files using -v in the image startup command line.
ADD         nginx.conf /etc/nginx/nginx.conf
ADD         php-fpm.conf /etc/php/php-fpm.conf

# Configure and launch the fastcgi PHP-FPM server
RUN         ln -s /dev/sdterr /var/log/php5-fpm.log && \
            /usr/sbin/php5-fpm --fpm-config /etc/php5/fpm/php-fpm.conf

# Last but least, unleach the daemon!
ENTRYPOINT   ["/usr/sbin/nginx"]
