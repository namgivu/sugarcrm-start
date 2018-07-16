#!/bin/bash

#local @ upload source code
scp -i "$ssh_key" "$local_path\SugarPro-8.0.0.zip" "root@$host_ip:/var/www/html"

#local @ ssh to host
ssh -i "$path_to_ssh_key" "root@$host_ip"
sudo apt-get update


#install LAMP@apache
sudo apt-get install -y apache2
sudo echo '
#fix warning about missing ServerName ref. https://unix.stackexchange.com/a/172532/17671
ServerName 127.0.0.1
' >> /etc/apache2/apache2.conf
sudo systemctl restart apache2
sudo apache2ctl configtest

#install LAMP@mysql
sudo apt-get install -y mysql-server #pls take note for root password
mysql_config_editor set --login-path=local --host=localhost --user=root --password #enter root password here #ref. https://stackoverflow.com/a/20854048/248616

#install LAMP@php7.1
sudo add-apt-repository -y ppa:ondrej/php -y && sudo apt-get update
sudo apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-mysql \
                        php7.1-gd php7.1-mbstring php7.1-mcrypt php7.1-curl php7.1-xml php7.1-zip

#apache @ set index.php on top
sudo vi /etc/apache2/mods-enabled/dir.conf
note='
line 2: move index.php to the 2nd position ie. after DirectoryIndex
'
sudo systemctl restart apache2

#unpack source code
sudo apt-get install unzip
cd /var/www/html && unzip SugarPro-8.0.0.zip
cd SugarPro-Full-8.0.0/ && mv * ../ && cd ../

#apache @ config site 's access permission
sudo a2enmod rewrite
w='/var/www/html' #www_root
sudo chown www-data:www-data -R "$w"
sudo chmod 755 -R "$w"
sudo chmod 755 -R "$w/cache/"
sudo chmod 755 -R "$w/custom/"
sudo chmod 755 -R "$w/data/"
sudo chmod 755 -R "$w/modules/"
sudo chmod 664 -R "$w/config.php"
sudo chmod 644 -R "$w/config_override.php"

vi /etc/php/7.1/apache2/php.ini
#edit file /etc/php/7.1/apache2/php.ini
note='
* after [mcrypt], add below line
extension=php_mcrypt.dll
* delete # before extension=php_mysqli.dll
'

service apache2 restart
sudo vi /var/www/html/.htaccess
chmod 664 -R /var/www/html/.htaccess

vi /etc/apache2/apache2.conf
#edit file
note='
Edit trong Directory /var/www/ : AllowOverride all
'
sudo apt-get install php7.1-bcmath
apt-get install php7.1-mcrypt
service apache2 restart
mysql -u root -p
create database sugarcrm

sudo apt-get install openjdk-8-jre-headless
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y install oracle-java8-installer

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update && sudo apt-get install elasticsearch

sudo vi /etc/elasticsearch/elasticsearch.yml
# edit file /etc/elasticsearch/elasticsearch.yml
note='
dong 17: cluster.name: sugarcrm
dong 23: node.name: node-1
'

sudo vi /etc/elasticsearch/jvm.options
#edit file /etc/elasticsearch/jvm.options
note='
dong 22, 23 edit thanh:
-Xms512m
-Xmx512m
'

sudo systemctl enable elasticsearch

