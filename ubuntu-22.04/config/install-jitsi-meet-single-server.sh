#!/bin/bash

# MultiServer setup: https://facsiaginsa.com/jitsi/install-jitsi-meet-with-multi-server-configuration
apt install net-tools

sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 3478/udp
sudo ufw allow 5349/tcp
sudo ufw allow 10000/udp
sudo ufw enable

curl https://download.jitsi.org/jitsi-key.gpg.key -o jitsi-key.gpg.key
sudo gpg --output /usr/share/keyrings/jitsi-key.gpg --dearmor jitsi-key.gpg.key
echo "deb [signed-by=/usr/share/keyrings/jitsi-key.gpg] https://download.jitsi.org stable/" >> /etc/apt/sources.list.d/jitsi-stable.list

curl https://prosody.im/files/prosody-debian-packages.key -o prosody-debian-packages.key
sudo gpg --output /usr/share/keyrings/prosody-keyring.gpg --dearmor prosody-debian-packages.key
echo "deb [signed-by=/usr/share/keyrings/prosody-keyring.gpg] http://packages.prosody.im/debian jammy main" >> /etc/apt/sources.list.d/prosody.list

rm jitsi-key.gpg.key prosody-debian-packages.key

sudo apt update
sudo apt install jitsi-meet

# Complete Uninstall
# sudo apt purge jigasi jitsi-meet jitsi-meet-web-config jitsi-meet-prosody jitsi-meet-turnserver jitsi-meet-web jicofo jitsi-videobridge2

# Log Files
# /var/log/jitsi/jvb.log
# /var/log/jitsi/jicofo.log
# /var/log/prosody/prosody.log

# Install Co-Turn
wget http://mirrors.edge.kernel.org/ubuntu/pool/universe/c/coturn/coturn_4.5.2-3.1_amd64.deb
sudo apt install ./coturn_4.5.2-3.1_amd64.deb
sudo apt install jitsi-meet-turnserver
