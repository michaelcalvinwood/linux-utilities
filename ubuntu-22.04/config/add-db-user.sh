#!/bin/bash
if [ -n "$1" ]; then
  User=$1
else
  echo "Enter First parameter: User Name"
  exit
fi

if [ -n "$2" ]; then
  Password=$2
else
  echo "Enter Second parameter: User Password"
  exit
fi

mysql -u root -e "CREATE USER '$User'@'%' IDENTIFIED BY '$Password';
GRANT ALL PRIVILEGES ON *.* TO '$User'@'%';
FLUSH PRIVILEGES;"