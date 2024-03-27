#!/bin/bash

add-apt-repository ppa:vbernat/haproxy-2.8 -y
apt install -y haproxy=2.8.\*
haproxy -v

systemctl status haproxy

systemctl enable haproxy

cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bk

