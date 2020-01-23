#!/usr/bin/env bash
set +x

#Setup Apache server
yum -y install httpd mod_ssl
systemctl enable httpd.service
systemctl start httpd.service

mkdir -p /etc/ssl/private
chmod 700  /etc/ssl/private

#Copy custom configuration:
cp /vagrant/ssl/server.key /vagrant/ssl/server.crt /etc/ssl/private
cp /vagrant/apache.conf/* /etc/httpd/conf.d/

#Update hostname on VM (Do the same on host manually or use autohostsupdater plugin for vagrant)
grep "ve-server1.com" /etc/hosts || cat /etc/hosts | sed -e 's/^127\.0\.0\.1 .*$/&1 ve-server1.com/'
# Reminder (see previous line)
echo "DO NOT FORGET TO UPDATE /etc/hosts ON YOUR HOST!"

apachectl configtest

#Restart server
systemctl restart httpd


