#!/bin/bash
(
echo -e "<VirtualHost *:80>\n\tDocumentRoot /var/www/html/glpi\n\n"
echo -e "\t<Directory /var/www/html/glpi>\n\t\tAllowOverride All\n"
echo -e "\t\tOrder Allow,Deny\n\t\tAllow from all\n\t</Directory>\n\n"
echo -e "\tErrorLog /dev/stderr\n\tLogLevel warn\n"
echo -e "\tCustomLog /dev/stdout combined\n"
echo -e "</VirtualHost>"
) > /etc/apache2/sites-available/000-default.conf

if [[ -z "${TZ}" ]]; then echo "TZ is unset"; 
else 
echo "date.timezone = \"$TZ\"" > /etc/php/8.1/apache2/conf.d/timezone.ini;
echo "date.timezone = \"$TZ\"" > /etc/php/8.1/cli/conf.d/timezone.ini;
fi

echo "*/2 * * * * www-data /usr/bin/php /var/www/html/glpi/front/cron.php &>/dev/null" >> /etc/cron.d/glpi
service cron start
a2enmod rewrite && service apache2 restart && service apache2 stop
/usr/sbin/apache2ctl -D FOREGROUND
