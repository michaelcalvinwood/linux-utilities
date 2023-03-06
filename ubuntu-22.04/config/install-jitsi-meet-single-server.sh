#!/bin/bash

mkdir /home/keys
cp treepad* /home/keys/
chmod 0755 -r /home/keys

# MultiServer setup: https://facsiaginsa.com/jitsi/install-jitsi-meet-with-multi-server-configuration
apt install net-tools

sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 3478/udp
sudo ufw allow 5349/tcp
sudo ufw allow 10000/udp
sudo ufw --force enable

curl https://download.jitsi.org/jitsi-key.gpg.key -o jitsi-key.gpg.key
sudo gpg --output /usr/share/keyrings/jitsi-key.gpg --dearmor jitsi-key.gpg.key
echo "deb [signed-by=/usr/share/keyrings/jitsi-key.gpg] https://download.jitsi.org stable/" >> /etc/apt/sources.list.d/jitsi-stable.list

curl https://prosody.im/files/prosody-debian-packages.key -o prosody-debian-packages.key
sudo gpg --output /usr/share/keyrings/prosody-keyring.gpg --dearmor prosody-debian-packages.key
echo "deb [signed-by=/usr/share/keyrings/prosody-keyring.gpg] http://packages.prosody.im/debian jammy main" >> /etc/apt/sources.list.d/prosody.list

rm jitsi-key.gpg.key prosody-debian-packages.key

sudo DEBIAN_FRONTEND=noninteractive apt update

cat << EOF | sudo debconf-set-selections
jitsi-videobridge   jitsi-videobridge/jvb-hostname  string  jitsi-test-02.treepadcloud.com
jitsi-meet-prosody  jitsi-videobridge/jvb-hostname  string  jitsi-test-02.treepadcloud.com
jitsi-meet-web-config	jitsi-meet/jaas-choice	boolean	false
jitsi-meet-web-config   jitsi-meet/cert-choice  select I want to use my own certificate
jitsi-meet-web-config   jitsi-meet/cert-path-crt    string  /home/keys/treepadcloud.com.pem
jitsi-meet-web-config   jitsi-meet/cert-path-key    string  /home/keys/treepadcloud.com.key
EOF


sudo DEBIAN_FRONTEND=noninteractive apt install -y jitsi-meet

# Complete Uninstall
# sudo apt purge jigasi jitsi-meet jitsi-meet-web-config jitsi-meet-prosody jitsi-meet-turnserver jitsi-meet-web jicofo jitsi-videobridge2

# Log Files
# /var/log/jitsi/jvb.log
# /var/log/jitsi/jicofo.log
# /var/log/prosody/prosody.log


