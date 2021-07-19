#!/bin/bash
sudo yum update -y && sudo yum upgrade
mv /etc/localtime /etc/localtime.bak
ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
yum install -y httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
# ec2-user (and any future members of the apache group) can add, delete, and edit files in the Apache document root, enabling you to add content, such as a static website or a PHP application.
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
sudo yum install php php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo -y
sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php
sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httdp.conf.bkp
sudo systemctl start httpd
sudo yum install git -y
cd /var/www/html/ && git init .
