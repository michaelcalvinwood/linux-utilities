#!/bin/bash

sudo apt update
sudo apt upgrade -y


add-apt-repository ppa:vbernat/haproxy-2.8 -y
apt install -y haproxy=2.8.\*
haproxy -v

systemctl status haproxy

systemctl enable haproxy

cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bk

apt install -y net-tools

ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

sudo ufw --force enable

