#!/bin/sh
sh -c "echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' > /etc/apt/sources.list.d/buster-backports.list"
apt update
apt install wireguard fail2ban ufw htop
cd /etc/wireguard
umask 077
wg genkey | tee privatekey | wg pubkey > publickey
cat privatekey | read serverpriv
cat publickey | read serverpub
mkdir /etc/wireguard/tmp
cd /etc/wireguard/tmp
wg genkey | tee privatekey | wg pubkey > publickey
cat privatekey | read clientpriv
cat publickey | read clientpub
cd /etc/wireguard/
sed -i '/net.ipv4.ip_forward=1/s/^#//g' /etc/sysctl.conf
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit2022/main/wireguard/wg0.conf
systemctl enable wg-quick@wg0
sudo ufw allow ssh
sudo ufw allow 51820/udp
sudo ufw allow 443/udp
sudo ufw allow 80/udp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
#iptables -I FORWARD -i wg0 -o wg0 -j ACCEPT
#sudo ufw allow in on wg0 to any
#sudo ufw allow out on wg0 to any
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
nano /etc/fail2ban/jail.local
sudo systemctl restart fail2ban.service
sudo systemctl enable fail2ban.service