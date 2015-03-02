# Kanboard

Kanboard is a simple visual task board web application.

Official website: http://kanboard.net

- Inspired by the Kanban methodology
- Get a visual and clear overview of your project
- Multiple boards with the ability to drag and drop tasks
- Minimalist software, focus only on essential features (Less is more)
- Open source and self-hosted
- Super simple installation

# Documentation
This installation is using Nginx, php5-fpm and SQLite to download and run the latest kanboard.

## Usage
_tl;dr_

Simply type the following command:
<code>docker run -d --name=kanboard -p 80:80 benoit/kanboard</code>
Now open your brower to http://127.0.0.1/kanboard and log in as admin/admin.

You can provide custom config files for nginx and php-fpm using external volumes:
- Nginx config file is /etc/nginx/nginx.conf
- php-fpm config file is /etc/php/fpm/php-fpm.conf

Users are strongly advised to store datas outside your Docker Container. You should have the folder /usr/share/nginx/html/kanboard/data mounted from an external volume.

Adapt the command line and your configuration to your needs.
