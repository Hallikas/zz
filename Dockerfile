#FROM phusion/baseimage:jammy-1.0.1
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
EXPOSE 80 443

ADD glpi-latest.tgz /var/www/html/

RUN \
	apt-get update && \
	apt install --yes \
		joe jq ca-certificates curl wget cron \
		apache2 libapache2-mod-php \
		php php-mysql php-ldap php-xmlrpc php-curl php-mbstring \
		php-gd php-imap php-cas php-intl php-zip php-bz2 php-redis \
		php-dom php-simplexml \
		composer yarnpkg \
	&&	chown -R www-data:www-data /var/www/html/

COPY glpi-start.sh /opt/
RUN chmod +x /opt/glpi-start.sh
ENTRYPOINT ["/opt/glpi-start.sh"]
