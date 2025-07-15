#!/bin/bash

set -e

echo "📦 Updating system..."
apt update && apt upgrade -y

echo "🌐 Installing Apache, PHP, and extensions..."
apt install -y apache2 mariadb-server php libapache2-mod-php php-mysql php-xml php-mbstring php-curl php-zip php-soap php-intl php-gd php-cli php-bcmath git unzip wget

echo "✅ Enabling PHP Apache module..."
a2enmod php8.1

echo "🔧 Creating custom PHP config override..."
echo "max_input_vars = 5000" > /etc/php/8.1/apache2/conf.d/99-custom-vars.ini
echo "memory_limit = 256M" >> /etc/php/8.1/apache2/conf.d/99-custom-vars.ini
echo "upload_max_filesize = 100M" >> /etc/php/8.1/apache2/conf.d/99-custom-vars.ini
echo "post_max_size = 100M" >> /etc/php/8.1/apache2/conf.d/99-custom-vars.ini

echo "🔁 Restarting Apache to apply PHP settings..."
service apache2 restart

echo "🚀 Starting MariaDB service..."
service mariadb start

echo "🗄️ Creating Moodle database and user..."
mysql -u root <<EOF
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'moodleuser'@'localhost' IDENTIFIED BY 'moodlepass';
GRANT ALL PRIVILEGES ON moodle.* TO 'moodleuser'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "📥 Downloading latest Moodle..."
cd /tmp
git clone -b MOODLE_403_STABLE git://git.moodle.org/moodle.git

echo "📂 Moving Moodle to web root..."
mv moodle /var/www/html/

echo "🔐 Fixing parent folder permissions..."
chown -R www-data:www-data /var/www
chmod -R 755 /var/www

echo "📁 Creating Moodle data directory..."
mkdir -p /var/www/moodledata
chown -R www-data:www-data /var/www/moodledata
chmod -R 755 /var/www/moodledata

echo "🧹 Cleaning Moodle cache, temp and session directories..."
rm -rf /var/www/moodledata/cache/*
rm -rf /var/www/moodledata/localcache/*
rm -rf /var/www/moodledata/sessions/*
rm -rf /var/www/moodledata/temp/*
rm -f /var/www/moodledata/climaintenance.html

echo "🛠️ Setting permissions for Moodle web files..."
chown -R www-data:www-data /var/www/html/moodle
chmod -R 755 /var/www/html/moodle

echo "✅ Setup complete!"
echo "🔗 Now open Moodle in browser: http://localhost:8080/moodle (or your server IP)"
echo "🧑 Complete the remaining setup through the browser UI (admin account etc)."
