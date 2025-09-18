#!/bin/bash
set -e

echo "Updating packages..."
sudo apt update -y

echo "Installing MySQL Server..."
sudo apt install -y mysql-server

echo "Starting MySQL service..."
sudo systemctl enable mysql
sudo systemctl start mysql

echo "Creating database and user..."
sudo mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS basic_tutorial;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON basic_tutorial.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "MySQL setup completed!"
