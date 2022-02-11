##!/bin/bash
# Installiere Shadowsocks und Passwort festlegen
apt-get update && apt-get upgrade -y
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee /etc/apt/sources.list.d/debian-buster-backports.list
apt-get update
apt -t buster-backports install shadowsocks-libev wget -y
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit2022/main/shadowsocks/config.json
mv -f config.json /etc/shadowsocks-libev/config.json
echo "Bitte Server Passwort für Shadowsocks eingegen: "
read password2
sed '/password/ s/" "/"'$password2'"/p' /etc/shadowsocks-libev/config.json
systemctl restart shadowsocks-libev