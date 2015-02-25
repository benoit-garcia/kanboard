FROM        nginx:latest
MAINTAINER  Benoit <benoit@terra-art.net>

# Expose HTTP port
EXPOSE      80
# Create a volume for web files
VOLUME      /srv/www
# Update package repository and install packages
RUN         LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get -y update && \
            LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get -y install nginx php5-fpm php5-sqlite wget unzip && \
            LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get clean && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configuration file must be set in the image startup command line (-v ..)

# Get Kanboard from official site
WORKDIR      /srv/www
ONBUILD RUN  wget http://kanboard.net/kanboard-latest.zip && \
             unzip kanboard-latest.zip && \
             chown -R www-data:www-data kanboard/data && \
             rm kanboard-latest.zip

# Last but least, unleach the daemon!
ENTRYPOINT   ["/usr/sbin/nginx"]
CMD          ["-g", "daemon off"]
