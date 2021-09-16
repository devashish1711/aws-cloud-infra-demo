#!/bin/bash
# Name: webserver.sh
# Owner: Saurav Mitra
# Description: Configure Nginx Webserver

sudo apt-get --assume-yes --quiet update                               >> /dev/null
sudo apt-get --assume-yes --quiet dist-upgrade                         >> /dev/null
sudo apt-get install software-properties-common --assume-yes --quiet   >> /dev/null
sudo add-apt-repository universe
sudo apt-get --assume-yes --quiet install nginx                        >> /dev/null

sed -i "s|^<title>Welcome to nginx\!</title>|<title>Nginx-AWS</title>|" /var/www/html/index.nginx-debian.html
sed -i "s|^<h1>Welcome to nginx\!</h1>|<h1>Welcome to nginx in AWS\!</h1>|" /var/www/html/index.nginx-debian.html
