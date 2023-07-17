#!/bin/bash
sudo apt update
sudo apt dist-upgrade -y
sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf
sudo sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf

sudo apt install npm -y
sudo npm install -g --unsafe-perm node-red
sudo npm install -g pm2
sudo pm2 start /usr/local/bin/node-red -- -v
sudo pm2 save
sudo pm2 startup
sudo pm2 startup systemd

cd ~/.node-red
npm install node-red-dashboard


npm install --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --production --engine-strict node-red-dashboard@3.5.0


sudo add-apt-repository ppa:mosquitto-dev/mosquitto-ppa -y
sudo apt install mosquitto -y

curl -X POST http://localhost:1880/flows -H 'content-type: application/json' -d @flows
