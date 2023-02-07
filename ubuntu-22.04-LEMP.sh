#!/bin/bash

if [ -n "$1" ]; then
  Domain=$1
else
  echo "Enter First parameter: Domain"
fi
exit


sudo apt update
sudo apt install nginx
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
sudo apt install mysql-server
sudo mysql_secure_installation
sudo apt install php8.1-fpm php-mysql
