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
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/openvpn/vpnserver?token=GHSAT0AAAAAABRB2ABR3GCQKETBTA66LYE6YQTJYJA
cp vpnserver?token=GHSAT0AAAAAABRB2ABR3GCQKETBTA66LYE6YQTJYJA /etc/init.d/vpnserver
mkdir /var/lock/subsys 
chmod 755 /etc/init.d/vpnserver && /etc/init.d/vpnserver start 
update-rc.d vpnserver defaults 
./vpncmd in /usr/local/vpnserver
ServerPasswordSet 
HubCreate myhub 
Hub myhub 
SecureNatEnable 
echo "Benutzername eingeben"
read username
UserCreate $username 
UserPasswordSet $username 
IPsecEnable
yes
ServerCertRegenerate ip/domain
ServerCertGet ~/cert.cer 
OpenVpnEnable yes /PORTS:1194 
OpenVpnMakeConfig ~/openvpn_config.zip 
ufw allow 500/udp && ufw allow 4500/udp && ufw allow 1194/udp 