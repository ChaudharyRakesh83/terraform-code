#!/bin/bash

sudo apt-get update -y
sudo apt-get install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx

echo "<h1> Install nginx via scripting and create instance via terraform code </h1>" | sudo tee /var/www/html/index.html


# --- Docker + Docker Compose setup ---
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# --- Monitoring stack folder ---
#mkdir -p /home/ubuntu/prom-grafana-setup
#cd /home/ubuntu/prom-grafana-setup
