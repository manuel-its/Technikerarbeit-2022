##!/bin/bash
#link https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/openvpn/openvpn.sh
apt-get update && apt-get upgrade -y
apt-get install build-essential gnupg2 gcc make wget ufw -y
#ufw default deny incoming && ufw default allow outgoing
#ufw allow from any to any proto tcp port 22,443, 1194
#ufw enable
cd home
wget http://www.softether-download.com/files/softether/v4.38-9760-rtm-2021.08.17-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz
tar -xvzf softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz
cd vpnserver
make
cd ..
mv vpnserver /usr/local/
cd /usr/local/vpnserver/
chmod 600 *
chmod 700 vpnserver
chmod 700 vpncmd
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/openvpn/vpnserver
mv vpnserver /etc/init.d/vpnserver
#mkdir /var/lock/subsys
chmod 755 /etc/init.d/vpnserver
/etc/init.d/vpnserver start
update-rc.d vpnserver defaults
cd /usr/local/vpnserver
./vpncmd
