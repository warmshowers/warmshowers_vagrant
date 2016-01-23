#!/bin/bash

echo "Provisioning virtual machine..."

# Updating the system
apt-get update

# Git
echo "Installing Git"
apt-get install git -y

# Rsync
echo "Installig Rsync"
apt-get -y install rsync

# Allow non-strict hsot key checking
touch ~/.ssh/config
cat <<EOF > ~/.ssh/config
Host wsupg.net
  StrictHostKeyChecking no
Host github.com
  StrictHostKeyChecking no
EOF

# Nginx
echo "Installing Nginx"
apt-get install nginx nginx-extras -y

# PHP
echo "Installing PHP"
apt-get install php5-common php5-dev php5-cli php5-fpm -y

echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y

# Composer - we may use this soon

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
ln -sf /etc/nginx/sites-available/wsupg.dev /etc/nginx/sites-enabled/wsupg.dev

rm -rf /etc/nginx/sites-enabled/default

# Nginx microcache
mkdir /var/cache/nginx/
mkdir /var/cache/nginx/microcache/
chown www-data:www-data /var/cache/nginx/microcache

# Test ssh connection to test server
status=$(ssh -q -o BatchMode=yes -o ConnectTimeout=5 vagrant@wsupg.net echo ok 2>&1)
if [[ $status == ok ]] ; then
echo "Ssh connection to vagrant@wsupg.net is good"
else
echo $status
echo "Can't connect to vagrant@wsupg.net, please contact project maintainers"
exit
fi

# Getting the database
echo "Gonna get you a database now, please be patient"
mkdir -p /var/backup
# rsync --progress vagrant@wsupg.net:~/vm-config/ws-sanitised.db /var/backup/

echo "Importing database"
mysql -u root -p1234 < /var/backup/ws-sanitised.db

# Getting the repository
echo "Cloning the repository"
mkdir -p /var/www && cd /var/www
chown -R vagrant:www-data /var/www
rm -fr /var/www/wsupg.dev
git clone -b site_d7 git@github.com:warmshowers/Warmshowers.org.git wsupg.dev

# Configure Drupal
echo "Configuring Drupal"
cp /vagrant/provision/config/drupal/settings.local.php /var/www/wsupg.dev/docroot/sites/default/settings.local.php
rsync --progress vagrant@wsupg.net:~/vm-config/settings.private.php /var/www/wsupg.dev/docroot/sites/default/

# Add host entries


# Restart Nginx for the config to take effect
service nginx restart

echo "Finished provisioning"
