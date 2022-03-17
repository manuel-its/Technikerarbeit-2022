##!/bin/bash
#https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/openvpn/openvpn.sh?token=GHSAT0AAAAAABSKUF6OPLBHSVCDFVOMCHDEYR42EEQ
apt-get update && apt-get upgrade -y
sudo apt-get install build-essential wget ufw -y
ufw default deny incoming && ufw default allow outgoing
ufw allow from any to any proto tcp port 22,443, 1194
ufw enable
echo "Bitte Link zu neuster Linux Server Version einfügen"
echo "Von hier: http://www.softether-download.com/files/softether/"
read link
wget $link
tar xzvf softether*
cd vpnserver && make
cd .. && mv vpnserver /usr/local 
cd /usr/local/vpnserver/
chmod 600 * 
chmod 700 vpnserver 
chmod 700 vpncmd
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/openvpn/vpnserver?token=GHSAT0AAAAAABSKUF6PYHLXCYAOKFNVOZWIYR4YF6A
mv vpnserver?token=GHSAT0AAAAAABSKUF6PYHLXCYAOKFNVOZWIYR4YF6A /etc/init.d/vpnserver
mkdir /var/lock/subsys 
chmod 755 /etc/init.d/vpnserver && /etc/init.d/vpnserver start 
update-rc.d vpnserver defaults 
./vpncmd
# ServerPasswordSet 
# 1
# HubCreate myhub 
# Hub myhub 
# SecureNatEnable 
# echo "Benutzername eingeben"
# read username
# UserCreate $username 
# UserPasswordSet $username 
# IPsecEnable
# yes
# ServerCertRegenerate 77.68.35.36
# ServerCertGet ~/cert.cer
# OpenVpnEnable yes /PORTS:1194
# OpenVpnMakeConfig ~/openvpn_config.zip
# ufw allow 500/udp && ufw allow 4500/udp && ufw allow 1194/udp