#!/bin/bash
ssh -i E:\sugar\tich-digitalocean-ssh\tich-digitalocean-ssh root@178.128.92.235
sudo apt-get update
sudo apt-get install apache2
sudo apache2ctl configtest
sudo systemctl restart apache2
sudo apt-get install mysql-server
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql

#edit file
sudo vi /etc/apache2/mods-enabled/dir.conf
s='
line 2: move index.php to first (sau DirectoryIndex)
'
sudo systemctl restart apache2
exit

scp -i E:\sugar\tich-digitalocean-ssh\tich-digitalocean-ssh E:\sugar\SugarPro-8.0.0.zip root@178.128.92.235:/var/www/html

ssh -i E:\sugar\tich-digitalocean-ssh\tich-digitalocean-ssh root@178.128.92.235
sudo apt-get install unzip
cd /var/www/html
unzip SugarPro-8.0.0.zip
cd SugarPro-Full-8.0.0/
mv * ../
cd ../
sudo a2enmod rewrite
sudo chmod 755 -R /var/www/html
chown www-data:www-data -R /var/www/html
chmod 755 -R /var/www/html/cache/
chmod 755 -R /var/www/html/custom/
chmod 755 -R /var/www/html/data/
chmod 755 -R /var/www/html/modules/
chmod 664 -R /var/www/html/config.php
chmod 644 -R /var/www/html/config_override.php

sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
service apache2 stop
sudo apt-get install php7.1 php7.1-common
sudo apt-get install php7.1-curl php7.1-xml php7.1-zip php7.1-gd php7.1-mysql php7.1-mbstring
sudo apt-get purge php7.0 php7.0-common
sudo apt-get install apache2
sudo apache2ctl configtest
sudo apt-get install mysql-server
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql
sudo vi /etc/apache2/mods-enabled/dir.conf
sudo systemctl restart apache2

vi /etc/php/7.1/apache2/php.ini
#edit file /etc/php/7.1/apache2/php.ini
s='
Them dong extension=php_mcrypt.dll sau [mcrypt]
delete # before extension=php_mysqli.dll
'

service apache2 restart
sudo vi /var/www/html/.htaccess
chmod 664 -R /var/www/html/.htaccess

vi /etc/apache2/apache2.conf
#edit file
s='
Edit trong Directory /var/www/ : AllowOverride all
'
sudo apt-get install php7.1-bcmath
apt-get install php7.1-mcrypt
service apache2 restart
mysql -u root -p
create database sugarcrm
exit

sudo apt-get install openjdk-8-jre-headless
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y install oracle-java8-installer

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update && sudo apt-get install elasticsearch

sudo vi /etc/elasticsearch/elasticsearch.yml
# edit file /etc/elasticsearch/elasticsearch.yml
s='
dong 17: cluster.name: sugarcrm
dong 23: node.name: node-1
'

sudo vi /etc/elasticsearch/jvm.options
#edit file /etc/elasticsearch/jvm.options
s='
dong 22, 23 edit thanh:
-Xms512m
-Xmx512m
'

sudo systemctl enable elasticsearch

