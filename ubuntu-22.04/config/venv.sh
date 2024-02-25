#!/bin/bash
if [ -n "$1" ]; then
  Directory=$1
else
  echo "Enter First parameter: Directory"
  exit
fi

sudo apt update
sudo apt upgrade
sudo apt-get install python3-pip
sudo apt install python3-venv -y
python3 -m venv $Directory
source $Directory/activate


# To deactivate run: source test/test_env/bin/activate
