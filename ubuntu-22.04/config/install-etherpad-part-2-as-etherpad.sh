git clone --branch master https://github.com/michaelcalvinwood/etherpad-lite.git

cd etherpad-lite
cp /opt/etherpad/settings.json .

npm install --no-save --legacy-peer-deps ep_webrtc
./bin/installDeps.sh

#run the etherpad server
bin/run.sh

node /opt/etherpad/etherpad-lite/src/node/server.js


#exit from etherpad user by typing exit

