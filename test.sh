#!/bin/bash
sudo apt update
sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf
sudo sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf

sudo apt install npm -y
sudo npm install -g --unsafe-perm node-red
sudo npm install -g pm2
sudo pm2 start /usr/local/bin/node-red -- -v
sudo pm2 save
sudo pm2 startup
sudo pm2 startup systemd


sudo add-apt-repository ppa:mosquitto-dev/mosquitto-ppa -y
sudo apt install mosquitto --assume-yes --allow
