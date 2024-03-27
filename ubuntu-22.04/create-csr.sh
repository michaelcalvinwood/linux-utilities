#!/bin/bash

if [ -n "$1" ]; then
  Domain=$1
else
  echo "Enter First parameter: Domain"
  exit
fi

cd /root/.ssh/
openssl req -new -newkey rsa:2048 -nodes -keyout $Domain.key -out $Domain.csr