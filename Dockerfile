FROM php:5.6-apache
MAINTAINER Hendrik 'Xendo' Meyer <mail@xendo.net>

ARG DocRoot=/srv/www/www

RUN apt-get update &&\
  apt-get install -y libmcrypt-dev zlib1g-dev &&\
  docker-php-ext-install sockets mcrypt mbstring zip &&\
  echo 'date.timezone = "UTC"' >> /usr/local/etc/php/php.ini &&\
  mkdir -p /srv/www/www &&\
  sed -ir "s;<Directory /var/www/>;<Directory ${DocRoot}>;gm" /etc/apache2/apache2.conf &&\
  sed -ir "s;DocumentRoot /var/www/html;DocumentRoot ${DocRoot};gm" /etc/apache2/apache2.conf
ADD ./default.html ${DocRoot}/index.html
WORKDIR ${DocRoot}

