#!/bin/bash

# Install docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker

# Run qdrant

mkdir /home/qdrant
docker pull qdrant/qdrant
docker run -d -p 6333:6333 \                                                   
    -v /home/qdrant/:/qdrant/storage \ 
    qdrant/qdrant

# Confirm qdrant is running

curl -X PUT 'http://localhost:6333/collections/test_collection' \
    -H 'Content-Type: application/json' \
    --data-raw '{
        "vectors": {
            "size": 4,
            "distance": "Dot"
        }
    }'

curl 'http://localhost:6333/collections/test_collection'

