apt update
apt upgrade -y -f
apt install mc screen git
apt install apache2 -y -f
apt install mysql-server -y -f
apt install php php-mysql php-ldap php-mcrypt php-cli php-soap php-json graphviz -y -f
apt install php-xml php-gd php-zip libapache2-mod-php -y -f
apt install php-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config -f -y
printf "\n" | pecl install mcrypt-1.0.4
printf "\n" | pecl upgrade-all
echo "extension=mcrypt.so" | tee -a /etc/php/7.4/apache2/conf.d/mcrypt.ini
service apache2 restart

