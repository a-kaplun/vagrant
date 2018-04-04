#!/bin/bash

# Update CentOS with any patchas
yum -y update --exclude=kernel

# Tools
yum -y install nano git unzip screen

# Apache
yum -y install httpd httpd-devel httpd-tools
systemctl enable httpd
systemctl stop httpd

# Create Symbolic lync beetween /vagrant and the root of the HTTPd
rm -rf /var/www/html
ln -s /vagrant /var/www/html

# Start Apache
systemctl start httpd

# PHP
yum -y install php php-cli php-common php-devel php-mysql

# MYSQL
yum -y install mysql mysql-server mysql-devel
systemctl enable mysqld
systemctl start mysqld

mysql -u root -e "SHOW DATABASES";

# Download Starter Content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/a-kaplun/vagrant/master/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/a-kaplun/vagrant/master/files/info.php

# Restart HTTPd
systemctl restart httpd
