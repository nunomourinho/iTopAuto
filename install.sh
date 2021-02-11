ITOP_VERSION=2.7.3
ITOP_FILENAME=iTop-2.7.3-6624.zip
export DEBIAN_FRONTEND=noninteractive
apt update
apt upgrade -y -f
apt install mc screen git -f -y
apt install apache2 -y -f
apt install mysql-server -y -f
apt install php php-mysql php-ldap php-mcrypt php-cli php-soap php-json graphviz -y -f
apt install php-xml php-gd php-zip libapache2-mod-php -y -f
apt install php-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config -f -y
apt install pwgen graphviz curl unzip php-mysql php-soap php-ldap php-mbstring expect net-tools -f -y
printf "\n" | pecl install mcrypt-1.0.4
printf "\n" | pecl upgrade-all
echo "extension=mcrypt.so" | tee -a /etc/php/7.4/apache2/conf.d/mcrypt.ini
service apache2 restart
./php-iniset file_uploads 1
./php-iniset upload_max_filesize 1G
./php-iniset max_file_uploads 20
./php-iniset post_max_size 2G
./php-iniset memory_limit 2G
./php-iniset max_input_time 3600
./mysql-initset max_allowed_packet 1073742324
update-alternatives --set php /usr/bin/php7.3


rm -rf /var/www/html/*
mkdir -p /tmp/itop
curl -SL -o /tmp/itop/itop.zip https://sourceforge.net/projects/itop/files/itop/$ITOP_VERSION/$ITOP_FILENAME/download
unzip -o /tmp/itop/itop.zip -d /tmp/itop/
mv /tmp/itop/web/* /var/www/html 
rm -rf /tmp/itop
chown -R www-data:www-data /var/www/html
passwordMysql=`pwgen -1 -y -n 14`
echo "Nova password para o utilizador root de mysql: $passwordMysql"
bash mysql_passwd "$passwordMysql"

echo "Nova password para o utilizador root de mysql: $passwordMysql"
apt install phpmyadmin -yq
echo "Nova password para o utilizador root de mysql: $passwordMysql" | tee password.txt

#bash ./create_mysql_admin



