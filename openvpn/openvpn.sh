##!/bin/bash
# wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/openvpn/openvpn.sh && chmod +x openvpn.sh && bash openvpn.sh
apt-get update -y
apt-get install build-essential gnupg2 gcc expect make -y
wget http://www.softether-download.com/files/softether/v4.38-9760-rtm-2021.08.17-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/openvpn/vpnserver
mv vpnserver /etc/init.d/vpnserver
tar -xvzf softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-x64-64bit.tar.gz
cd vpnserver
make
cd ..
mv vpnserver /usr/local/
cd /usr/local/vpnserver/
chmod 600 *
chmod 700 vpnserver
chmod 700 vpncmd
chmod 755 /etc/init.d/vpnserver
/etc/init.d/vpnserver start
update-rc.d vpnserver defaults
/usr/local/vpnserver/./vpncmd