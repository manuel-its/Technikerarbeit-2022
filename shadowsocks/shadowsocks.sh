##!/bin/bash
# Installiere Shadowsocks und Passwort festlegen
apt-get update && apt-get upgrade -y
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee /etc/apt/sources.list.d/debian-buster-backports.list
apt-get update
apt -t buster-backports install shadowsocks-libev wget -y
#wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/shadowsocks/config.json
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/shadowsocks/config.json?token=GHSAT0AAAAAABRB2ABQBKKL57QNYPYEGWWQYQRBW4A
cp 
mv -f config.json?token=GHSAT0AAAAAABRB2ABQBKKL57QNYPYEGWWQYQRBW4A /etc/shadowsocks-libev/config.json
echo "Bitte Server Passwort für Shadowsocks eingegen: "
read password
sed '/password/ s/" "/"'$password'"/p' /etc/shadowsocks-libev/config.json
systemctl restart shadowsocks-libev