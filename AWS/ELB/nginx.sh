#!/bin/bash

apt-get update -y
apt-get install -y net-tools nginx

systemctl start nginx
systemctl enable nginx

MyIP=$(ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{print $2}' | head -n 1)

echo "<h1>Welcome to GIBS ELB</h1><br><h2>My Private IP is: $MyIP</h2>" > /var/www/html/index.html