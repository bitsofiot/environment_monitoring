#!/bin/bash

echo -e "\n\n\n\n updating ............................................................."
apt update
apt dist-upgrade -y
sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf


echo -e "\n\n\n\nv installing mosquito ............................................................."
add-apt-repository ppa:mosquitto-dev/mosquitto-ppa -y
apt install mosquitto -y
chmod 755 /etc/mosquitto/
echo "listener 1883 0.0.0.0" >> /etc/mosquitto/mosquitto.conf
echo "allow_anonymous true" >> /etc/mosquitto/mosquitto.conf


echo -e "\n\n\n\n installing NPM ............................................................."
apt install npm -y


echo -e "\n\n\n\n\n NodeJs ............................................................."
npm install -g n 

echo -e "\n\n\n\n\n updating NodeJs............................................................."
n latest

echo -e "\n\n\n\n\n Node-red ............................................................."
npm install -g --unsafe-perm node-red
#cd ~/.node-red

echo -e "\n\n\n\n\n Install Dashboard for Node-red ............................................................."
npm install node-red-dashboard

echo -e "\n\n\n\n\n PM2 ............................................................."
npm install -g pm2
pm2 start /usr/local/bin/node-red -- -v
pm2 save
pm2 startup
pm2 startup systemd

echo -e "\n\n\n\n\n\n Installing requirment for importing Flows ............................................................."
npm install --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --production --engine-strict node-red-dashboard@3.5.0


echo -e "\n\n\n\n\n\n Downloading and Importing Flows ............................................................."
wget https://raw.githubusercontent.com/bitsofiot/udemy/main/flows
curl -X POST http://localhost:1880/flows -H 'content-type: application/json' -d @flows
