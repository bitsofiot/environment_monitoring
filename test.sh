#!/bin/bash
apt update
apt dist-upgrade -y
sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf



add-apt-repository ppa:mosquitto-dev/mosquitto-ppa -y
apt install mosquitto -y

chmod 755 /etc/mosquitto/

echo "listener 1883 0.0.0.0" >> /etc/mosquitto/mosquitto.conf
echo "allow_anonymous true" >> /etc/mosquitto/mosquitto.conf


n latest

apt install npm -y
# npm install -g n 
npm install -g --unsafe-perm node-red
npm install -g pm2
pm2 start /usr/local/bin/node-red -- -v
pm2 save
pm2 startup
pm2 startup systemd

cd ~/.node-red
npm install node-red-dashboard


#npm install --no-audit --no-update-notifier --no-fund --save --save-prefix=~ --production --engine-strict node-red-dashboard@3.5.0



#wget https://raw.githubusercontent.com/bitsofiot/udemy/main/flows
#curl -X POST http://localhost:1880/flows -H 'content-type: application/json' -d @flows
