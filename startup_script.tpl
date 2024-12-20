#!/bin/bash
sudo yum update -y
sudo yum install -y nginx
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo 'Hello world' | sudo tee /usr/share/nginx/html/index.html