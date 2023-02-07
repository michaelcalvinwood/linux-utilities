sudo snap install core; 
sudo snap refresh core

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'

sudo certbot --nginx -d $1 --non-interactive --agree-tos -m admin@pymnts.com

sudo certbot --nginx -d www.$1 --non-interactive --agree-tos -m admin@pymnts.com