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
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON basic_tutorial.* TO 'root'@'%';
FLUSH PRIVILEGES;
EOF

echo "Configuring MySQL to listen on all interfaces..."
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

echo "Restarting MySQL..."
sudo systemctl restart mysql

echo "MySQL setup completed!"
