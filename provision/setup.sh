#!/bin/bash

echo "Provisioning virtual machine..."

# Git
echo "Installing Git"
apt-get install git -y

# Nginx
echo "Installing Nginx"
apt-get install nginx -y

# PHP
echo "Installing PHP"
apt-get install php5-common php5-dev php5-cli php5-fpm -y

echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y

# MySQL 
echo "Preparing MySQL"
apt-get install debconf-utils -y
debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"

echo "Installing MySQL"
apt-get install mysql-server -y

# Nginx Configuration
echo "Configuring Nginx"
cp -rT /vagrant/provision/config/nginx/ /etc/nginx/
ln -s /etc/nginx/sites-available/wsupg.dev /etc/nginx/sites-enabled/wsupg.dev

rm -rf /etc/nginx/sites-available/default

# Getting the database

# Getting the repository

# Restart Nginx for the config to take effect
service nginx restart

echo "Finished provisioning."
