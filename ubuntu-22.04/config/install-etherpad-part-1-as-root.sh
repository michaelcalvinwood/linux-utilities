#!/bin/bash
# https://www.digitalocean.com/community/tutorials/how-to-install-the-etherpad-collaborative-web-editor-on-ubuntu-20-04
# https://www.rosehosting.com/blog/install-etherpad-on-ubuntu-20-04/

if [ -n "$1" ]; then
  Password=$1
else
  echo "Enter First parameter: Database Password"
  exit
fi

sudo DEBIAN_FRONTEND=noninteractive apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install libssl-dev pkg-config git gcc g++ make build-essential gnupg2 -y

# Install nodeJS
sudo apt update
curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sudo DEBIAN_FRONTEND=noninteractive bash nodesource_setup.sh
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# Install pm2 node process manager
npm i pm2 -g

npm install -g npm@9.5.1

# Install and Configure mysql
sudo ufw allow mysql
sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server

mysql -e "create database etherpaddb;"
mysql -e "CREATE USER etherpad@localhost IDENTIFIED BY '$Password';"
mysql -e "grant all on etherpaddb.* to etherpad@localhost;"
mysql -e "ALTER USER 'etherpad'@'localhost' IDENTIFIED WITH mysql_native_password BY '$Password';"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$Password';"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
mysql -e "FLUSH PRIVILEGES"

cp mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf



# install ssl
mkdir /home/keys
cp treepadcloud.com.key /home/keys
cp treepadcloud.com.pem /home/keys
chmod 0755 /home/keys/*

# Install and Configure NODE PROXY!!!!


# create etherpad user
adduser --home /opt/etherpad --shell /bin/bash --disabled-password --gecos "" etherpad
# make etherpad a sudo user
usermod -aG sudo etherpad

# install etherpad
sudo DEBIAN_FRONTEND=noninteractive install -d -m 755 -o etherpad -g etherpad /opt/etherpad

# copy settings.json to a place where etherpad user can access it
cp settings.json /opt/etherpad
cp install-etherpad-part-2-as-etherpad.sh /opt/etherpad
chmod 0777 /opt/etherpad/install-etherpad-part-2-as-etherpad.sh

su - etherpad





