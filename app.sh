sudo apt update && sudo apt upgrade

sudo apt install software-properties-common

sudo add-apt-repository ppa:ondrej/php

sudo apt update

sudo apt -y install php8.0

sudo apt install php8.0-mysqli

sudo rm -rf /var/www/html
sudo cd /var/www/
sudo git clone https://github.com/MrInternauta/Web_POS-MVC
sudo mv Web_POS-MVC/ html/