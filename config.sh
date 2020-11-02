#!/bin/bash

### Script to configure the server with our KMM web and config
### Pablo Corral and Aritz Herrero
### KMM - 20/21

#update the system
echo "update system"
sudo apt-get update && sudo apt-get upgrade -y

#install all the necessary packages
echo "install packages"
sudo apt-get install nginx ffmpeg gpac php-fpm php-mysql -y
sudo apt-get install libnginx-mod-rtmp -y

#Clone the web repo and own it
echo "clone the web from github"
sudo git clone https://github.com/Aritzherrero4/KMM-Web.git /var/www/pabloaritz.com/
sudo chown -R kmm /var/www/pabloaritz.com/

#copy the configs files to the nginx dir
echo "Copy all the config files"
sudo rm /etc/nginx/nginx.conf
sudo cp configs/nginx.conf /etc/nginx/nginx.conf
sudo cp configs/pabloaritz.com /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/pabloaritz.com /etc/nginx/sites-enabled/pabloaritz.com
sudo rm /etc/nginx/sites-enabled/default

#update php-fpm php.ini
echo "update php-fpm config file"
sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/*/fpm/php.ini

#restart the services
echo "restart services"
sudo systemctl restart nginx.service
sudo systemctl restart php*

echo "done"
