#!/bin/bash
apt-get update
apt-get install apache2 -y
systemctl start apache2
systemctl enable apache2
echo "<h1>Deployed through Terraform</h1>" | sudo tee /var/www/html/index.html