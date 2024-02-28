# Install nodeJS

if [ -n "$1" ]; then
  Domain=$1
else
  echo "Enter First parameter: Database Passwords"
  exit
fi


sudo apt update
sudo apt upgrade -y
curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs

# Install pm2 node process manager
npm i pm2 -g

npm install -g npm@9.5.1

# Install and Configure mysql
sudo ufw allow mysql
sudo apt install -y mysql-server

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$1';"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
mysql -e "FLUSH PRIVILEGES"

cp mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql

# Install redis
sudo apt install -y redis-server
ufw allow 6379/tcp
rm /etc/redis/redis.conf
mv redis.conf /etc/redis/redis.conf

chown -R redis:redis /var/log/redis
chmod -R u+rwX,g+rwX,u+rx /var/log/redis
chmod +r /etc/redis/redis.conf

systemctl restart redis