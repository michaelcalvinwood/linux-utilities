#!/bin/bash
apt update -y
apt upgrade

# Add PPA for PHP 8.1
apt install software-properties-common
add-apt-repository ppa:ondrej/php
apt update

# Install PHP 8.1 FPM
apt install php8.1-fpm php8.1-common php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-soap php8.1-zip php8.1-bcmath -y
service php8.1-fpm status

# Install Apache
apt install apache2

# Configure Apache with PHP-FPM
a2dissite 000-default
a2dismod php7.4
a2dismod mpm_prefork
a2enmod mpm_event proxy_fcgi setenvif
a2enconf php8.1-fpm
# if needed: a2enmod http2

# Update php.ini. See php.ini settings file
systemctl restart php8.1-fpm

# Configure Virtual Host. See sampleVirtualHost.conf
    #a2ensite domain.conf

#service apache2 restart

# Confirm installation be creating info.php in root of domain
# <?php phpinfo();


