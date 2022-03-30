#!/bin/sh
apt update
apt install wireguard fail2ban ufw htop
cd /etc/wireguard
umask 077
wg genkey | tee privatekey | wg pubkey > publickey
cat privatekey | read serverprivate
cat publickey | read serverpublic
mkdir /etc/wireguard/tmp
cd /etc/wireguard/tmp
wg genkey | tee privatekey | wg pubkey > publickey
cat privatekey | read clientprivate
cat publickey | read clientpublic
cd /etc/wireguard/
rm wg0.conf
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit2022/main/wireguard/wg0.conf
sed -i 's/Server Private Key/'$serverprivate'/' wg0.conf
sed -i 's/Client Public Key/'$clientpublic'/' wg0.conf
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
systemctl enable wg-quick@wg0
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/wireguard/client.conf
sed -i 's/Client Private Key/'$clientprivate'/' wg0.conf
sed -i 's/Server Public Key/'$serverpublic'/' wg0.conf
ufw allow from any to any proto tcp port 22,443,1194
ufw allow from any to any proto udp port 51820