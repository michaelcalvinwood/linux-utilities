#!/bin/bash

if [ -n "$1" ]; then
  Domain=$1
else
  echo "Enter First parameter: Domain"
  exit
fi

if [ -n "$2" ]; then
  DBPassword=$2
else
  echo "Enter Second parameter: DBPassword"
  exit
fi

sudo apt update
sudo apt install -y nginx
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
sudo apt install -y mysql-server
sudo apt install -y php8.1-fpm php-mysql

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$DBPassword') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

sudo mkdir /var/www/$Domain

sudo chown -R $USER:$USER /var/www/$Domain

printf "server {
    listen 80;
    server_name your_domain www.$Domain;
    root /var/www/$Domain;

    index index.html index.htm index.php;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
     }

    location ~ /\.ht {
        deny all;
    }

}" > /etc/nginx/sites-available/$Domain

sudo ln -s /etc/nginx/sites-available/$Domain /etc/nginx/sites-enabled/

sudo unlink /etc/nginx/sites-enabled/default

sudo nginx -t

sudo systemctl reload nginx

printf "<html>
  <head>
    <title>your_domain website</title>
  </head>
  <body>
    <h1>Hello World!</h1>

    <p>This is the landing page of <strong>$Domain</strong>.</p>
  </body>
</html>" > /var/www/$Domain/index.html

printf "<?php
phpinfo();" > /var/www/$Domain/info.php

