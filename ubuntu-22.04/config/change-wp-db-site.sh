#!/bin/bash

if [ -n "$1" ]; then
  Domain=$1
else
  echo "Enter First Parameter: Site domain (e.g. pymnts.com)"
  exit
fi

if [ -n "$2" ]; then
  Db=$2
else
  echo "Enter Second Parameter: Database Name"
  exit
fi

mysql -u root -e "update wp_options set option_value = '$Domain' where
option_name = 'siteurl';" $Db

mysql -u root -e "update wp_options set option_value = '$Domain' where option_name = 'home';" $Db

