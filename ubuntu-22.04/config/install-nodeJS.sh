# Install nodeJS
sudo apt update
curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs

# Install pm2 node process manager
npm i pm2 -g

npm install -g npm@9.5.0