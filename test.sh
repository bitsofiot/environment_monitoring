#!/bin/bash
sudo su
sudo apt update
sudo echo "$nrconf{restart} = 'a';" >> /etc/needrestart/needrestart.conf
sudo apt install npm -y
sudo npm install -g --unsafe-perm node-red
sudo npm install -g pm2
sudo pm2 start /usr/local/bin/node-red -- -v
sudo pm2 save
sudo pm2 startup
sudo pm2 startup systemd
node-red
