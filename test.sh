#!/bin/bash
sudo apt update
sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf
sudo apt install npm -y
npm install -g --unsafe-perm node-red
npm install -g pm2
pm2 start /usr/local/bin/node-red -- -v
pm2 save
pm2 startup
pm2 startup systemd
node-red
