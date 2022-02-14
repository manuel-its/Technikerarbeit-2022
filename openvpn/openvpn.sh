##!/bin/bash
# Installiere VPN
apt-get update && apt-get upgrade -y
sudo apt-get install build-essential wget -y
echo "Bitte Link zu neuster Linux Server Version einfügen"
echo "http://www.softether-download.com/files/softether/"
read link
wget $link
tar xzvf softether*
cd vpnserver && make
cd .. && mv vpnserver /usr/local 
cd /usr/local/vpnserver/
chmod 600 * chmod 700 vpnserver 
chmod 700 vpncmd
wget 

