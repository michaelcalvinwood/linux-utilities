#!/bin/bash
if [ -n "$1" ]; then
  Domain=$1
else
  echo "Param 1 must be domain name"
  exit
fi

sudo openssl req -new -newkey rsa:2048 -nodes -keyout $Domain.key -out $Domain.csr