# Install redis
sudo apt install -y redis-server
ufw allow 6379/tcp
rm /etc/redis/redis.conf
mv redis.conf /etc/redis/redis.conf

chown -R redis:redis /var/log/redis
chmod -R u+rwX,g+rwX,u+rx /var/log/redis
chmod +r /etc/redis/redis.conf


systemctl restart redis
# To complete redis configuration follow: https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-22-04
