#!/bin/bash
sudo echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
apt-key adv --fetch-keys 'https://packages.sury.org/php/apt.gpg' > /dev/null 2>&1
sudo apt-get update && apt-get upgrade -y
sudo apt-get install ca-certificates apt-transport-https software-properties-common php8.0 php8.0-mysql apache2 mariadb-server mariadb-client -y
wget https://raw.githubusercontent.com/manuel-its/Technikerarbeit-2022/main/wordpress/vpn-mig.com-multi.conf
cp vpn-mig.com-multi.conf /etc/apache2/sites-available/
rm /var/www/html/index.html
# cd /var/www/
# sudo wget https://de.wordpress.org/latest-de_DE.tar.gz
# sudo tar xzvf latest-de_DE.tar.gz
# sudo mv /var/www/wordpress/ /var/www/html/
# sudo rm /var/www/latest-de_DE.tar.gz
# sudo rm /var/www/html/index.html
cpio -id < /var/www/wp.cpio
mysqldump -u root wpdb < /var/www/wpdb.sql
cd /var/www/html/wordpress/ && sudo cp wp-config-sample.php wp-config.php
sudo chown -R www-data:www-data /var/www/html/wordpress
echo "CREATE DATABASE wpdb;" | sudo mysql -u root
dbpassword=$(openssl rand -base64 32)
echo "GRANT ALL PRIVILEGES ON wpdb.* to wpuser@localhost identified by \"${dbpassword}\";" | sudo mysql -u root
echo "FLUSH PRIVILEGES;" | sudo mysql -u root
sudo sed -i "s|passwort_hier_einfuegen|$dbpassword|" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/datenbankname_hier_einfuegen/wpdb/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/benutzername_hier_einfuegen/wpuser/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/; short_open_tag/short_open_tag = On/" /etc/php/8.0/apache2/php.ini
sudo sed -i "s/memory_limit = 128M/memory_limit = 256M/" /etc/php/8.0/apache2/php.ini
sudo sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 200M/" /etc/php/8.0/apache2/php.ini
sudo sed -i "s/max_execution_time = 30/max_execution_time = 360/" /etc/php/8.0/apache2/php.ini
sudo certbot certonly --agree-tos --email info-vpn-mig@protonmail.com --webroot -w /var/www/html -d vpn-mig.com -d www.vpn-mig.com
#sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"
#sudo sed -i "s|/etc/ssl/certs/ssl-cert-snakeoil.pem|/etc/ssl/certs/apache-selfsigned.crt|" /etc/apache2/sites-available/default-ssl.conf
#sudo sed -i "s|/etc/ssl/private/ssl-cert-snakeoil.key|/etc/ssl/private/apache-selfsigned.key|" /etc/apache2/sites-available/default-ssl.conf
sudo a2enmod ssl
sudo service apache2 restart
a2dissite 000-default.conf
a2dissite default-ssl.conf
sudo a2ensite vpn-mig.com-multi.conf
sudo service apache2 restart

