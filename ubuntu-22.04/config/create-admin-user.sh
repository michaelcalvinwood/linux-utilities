if [ -n "$1" ]; then
  Name=$1
else
  echo "Enter First parameter: UserName"
  exit
fi

adduser $Name
usermod -aG sudo $Name
rsync --archive --chown=$Name:$Name ~/.ssh /home/$Name
ufw allow OpenSSH
ufw allow 22/tcp
ufw enable

#IMPORTANT: echo {sudoPassword} | sudo -S {command to run}