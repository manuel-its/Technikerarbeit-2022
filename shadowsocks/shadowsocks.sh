##!/bin/bash
#Shadowsocks
#SQL Abfrage nach Benutzername E-Mail und Passwort
echo "Eingabe Zahl:"
echo "1 Shadowsocks Installieren"
echo "2 User hinzufügen(Multiuser einrichten)"
echo "3 Multiuser deaktivieren"
echo "4 Shadowsocks entfernen"
read auswahl
case $auswahl in
   1)   
apt-get update && apt-get upgrade -y
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee /etc/apt/sources.list.d/debian-buster-backports.list
apt-get update
apt -t buster-backports install shadowsocks-libev wget ufw -y
ufw default deny incoming && ufw default allow outgoing && ufw allow 22/tcp && ufw allow 80/tcp && ufw allow 443/tcp && ufw allow 80/udp && ufw allow 443/udp
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/shadowsocks/config.json?token=GHSAT0AAAAAABRB2ABQBKKL57QNYPYEGWWQYQRBW4A
mv -f config.json?token=GHSAT0AAAAAABRB2ABQBKKL57QNYPYEGWWQYQRBW4A /etc/shadowsocks-libev/config.json
echo "Bitte Server Passwort für Shadowsocks eingegen: "
read password
sed '/password/ s/" "/"'$password'"/p' /etc/shadowsocks-libev/config.json
systemctl restart shadowsocks-libev ;;
   2) echo "Wie viele User sollen erstellt werden?"
read anzahluser
for ((n=1;n<=anzahluser;n++))
do
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/shadowsocks/config.json?token=GHSAT0AAAAAABRB2ABQJ4BU7HBRQSZ53OXUYQUW44A
mv config.json?token=GHSAT0AAAAAABRB2ABQJ4BU7HBRQSZ53OXUYQUW44A /etc/shadowsocks-libev/user$n
forpassword=$(openssl rand -base64 32)
echo $forpassword
sed '/password/ s/" "/"'$forpassword'"/p' /etc/shadowsocks-libev/config$n.json
systemctl enable shadowsocks-libev-server@user$n.service –now
done ;;
   3) anzahl=$(find /etc/shadowsocks-libev/ -type f | wc -l)
if $anzahl>=2
then
   anzahl=anzahl-1
   for ((n=1;n<=anzahl;n++))
   do
   systemctl disable shadowsocks-libev-server@user$n.service –now
   rm /etc/shadowsocks-libev/config$n.json
   done
fi ;;		  
esac

