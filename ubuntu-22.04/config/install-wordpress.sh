# Install WordPress: https://www.linode.com/docs/guides/how-to-install-wordpress-ubuntu-22-04/
if [ -n "$1" ]; then
  Database=$1
else
  echo "Enter First parameter: Database Name"
  exit
fi

if [ -n "$2" ]; then
  User=$2
else
  echo "Enter Second parameter: Database User Name"
  exit
fi

if [ -n "$3" ]; then
  Password=$3
else
  echo "Enter Third parameter: Database Password"
  exit
fi

if [ -n "$4" ]; then
  Host=$4
else
  echo "Enter Fourth parameter: Host"
  exit
fi


mysql -u root -e "CREATE DATABASE $Database";

mysql -u root -e "CREATE USER '$User'@'%' IDENTIFIED BY '$Password';
GRANT ALL PRIVILEGES ON $User.* TO '$User'@'%';
FLUSH PRIVILEGES;"

sudo apt install -y php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap

sudo systemctl restart nginx

rm -rf /vaw/www/$Host/

sudo mkdir -p /var/www/$Host/src

cd /var/www/$Host/src

sudo wget http://wordpress.org/latest.tar.gz

sudo tar -xvf latest.tar.gz

sudo mv latest.tar.gz wordpress-`date "+%Y-%m-%d"`.tar.gz

sudo mv wordpress/* ../

sudo chown -R www-data:www-data /var/www/$Host
sudo find /var/www/$Host/ -type d -exec chmod 750 {} \;
sudo find /var/www/$Host/ -type f -exec chmod 640 {} \;

# visit domain to finish setting up

curl -s https://api.wordpress.org/secret-key/1.1/salt/
echo "Visit domain to finish setup";

