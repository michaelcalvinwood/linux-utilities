#!/bin/bash
# Install certbot
sudo snap install core; 
sudo snap refresh core

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo "certbot certonly -d example.com"

