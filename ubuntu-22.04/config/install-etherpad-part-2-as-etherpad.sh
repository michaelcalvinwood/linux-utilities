git clone --branch master https://github.com/michaelcalvinwood/etherpad-lite.git

cd etherpad-lite

#run the etherpad server
bin/run.sh

cp /opt/etherpad/settings.json .
./bin/installDeps.sh

#exit from etherpad user by typing exit

