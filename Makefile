build: check generate php


php: php-cli php-apache
php-cli: php5.4-cli php5.5-cli php5.6-cli php7-cli
php-apache: php5.4-apache php5.5-apache php5.6-apache php7-apache


rebuild: clean build


check: src/Dockerfile_BASE src/APACHE1 src/APACHE2 src/APACHE3
	docker ps


generate: generate-cli generate-apache
generate-cli: generate5.4-cli generate5.5-cli generate5.6-cli generate7-cli
generate-apache: generate5.4-apache generate5.5-apache generate5.6-apache generate7-apache

generate5.4-cli: check
	sed -r 's/%IMAGE%/php:5.4-cli/g' src/Dockerfile_BASE > Dockerfile5.4-cli
	sed -ri 's/%APACHE1%//g' Dockerfile5.4-cli
	sed -ri 's/%APACHE2%//g' Dockerfile5.4-cli
	sed -ri 's/%APACHE3%//g' Dockerfile5.4-cli
generate5.5-cli: check
	sed -r 's/%IMAGE%/php:5.5-cli/g' src/Dockerfile_BASE > Dockerfile5.5-cli
	sed -ri 's/%APACHE1%//g' Dockerfile5.5-cli
	sed -ri 's/%APACHE2%//g' Dockerfile5.5-cli
	sed -ri 's/%APACHE3%//g' Dockerfile5.5-cli
generate5.6-cli: check
	sed -r 's/%IMAGE%/php:5.6-cli/g' src/Dockerfile_BASE > Dockerfile5.6-cli
	sed -ri 's/%APACHE1%//g' Dockerfile5.6-cli
	sed -ri 's/%APACHE2%//g' Dockerfile5.6-cli
	sed -ri 's/%APACHE3%//g' Dockerfile5.6-cli
generate7-cli: check
	sed -r 's/%IMAGE%/php:7-cli/g' src/Dockerfile_BASE > Dockerfile7-cli
	sed -ri 's/%APACHE1%//g' Dockerfile7-cli
	sed -ri 's/%APACHE2%//g' Dockerfile7-cli
	sed -ri 's/%APACHE3%//g' Dockerfile7-cli
generate5.4-apache: check
	sed 's/%IMAGE%/php:5.4-apache/g' src/Dockerfile_BASE > Dockerfile5.4-apache
	sed -i "/%APACHE1%/r src/APACHE1" Dockerfile5.4-apache
	sed -i "s/%APACHE1%//g" Dockerfile5.4-apache
	sed -i "/%APACHE2%/r src/APACHE2" Dockerfile5.4-apache
	sed -i "s/%APACHE2%//g" Dockerfile5.4-apache
	sed -i "/%APACHE3%/r src/APACHE3" Dockerfile5.4-apache
	sed -i "s/%APACHE3%//g" Dockerfile5.4-apache
generate5.5-apache: check
	sed -r 's/%IMAGE%/php:5.5-apache/g' src/Dockerfile_BASE > Dockerfile5.5-apache
	sed -i "/%APACHE1%/r src/APACHE1" Dockerfile5.5-apache
	sed -i "s/%APACHE1%//g" Dockerfile5.5-apache
	sed -i "/%APACHE2%/r src/APACHE2" Dockerfile5.5-apache
	sed -i "s/%APACHE2%//g" Dockerfile5.5-apache
	sed -i "/%APACHE3%/r src/APACHE3" Dockerfile5.5-apache
	sed -i "s/%APACHE3%//g" Dockerfile5.5-apache
generate5.6-apache: check
	sed -r 's/%IMAGE%/php:5.6-apache/g' src/Dockerfile_BASE > Dockerfile5.6-apache
	sed -i "/%APACHE1%/r src/APACHE1" Dockerfile5.6-apache
	sed -i "s/%APACHE1%//g" Dockerfile5.6-apache
	sed -i "/%APACHE2%/r src/APACHE2" Dockerfile5.6-apache
	sed -i "s/%APACHE2%//g" Dockerfile5.6-apache
	sed -i "/%APACHE3%/r src/APACHE3" Dockerfile5.6-apache
	sed -i "s/%APACHE3%//g" Dockerfile5.6-apache
generate7-apache: check
	sed -r 's/%IMAGE%/php:7-apache/g' src/Dockerfile_BASE > Dockerfile7-apache
	sed -i "/%APACHE1%/r src/APACHE1" Dockerfile7-apache
	sed -i "s/%APACHE1%//g" Dockerfile7-apache
	sed -i "/%APACHE2%/r src/APACHE2" Dockerfile7-apache
	sed -i "s/%APACHE2%//g" Dockerfile7-apache
	sed -i "/%APACHE3%/r src/APACHE3" Dockerfile7-apache
	sed -i "s/%APACHE3%//g" Dockerfile7-apache

php5.4-cli: check generate5.4-cli
	docker build -t php-env:5.4-cli $(OPTS) -f Dockerfile5.4-cli .
php5.5-cli: check generate5.5-cli
	docker build -t php-env:5.5-cli $(OPTS) -f Dockerfile5.5-cli .
php5.6-cli: check generate5.6-cli
	docker build -t php-env:5.6-cli $(OPTS) -f Dockerfile5.6-cli .
php7-cli: check generate7-cli
	docker build -t php-env:7-cli $(OPTS) -f Dockerfile7-cli .
php5.4-apache: check generate5.4-apache
	docker build -t php-env:5.4-apache $(OPTS) -f Dockerfile5.4-apache .
php5.5-apache: check generate5.5-apache
	docker build -t php-env:5.5-apache $(OPTS) -f Dockerfile5.5-apache .
php5.6-apache: check generate5.6-apache
	docker build -t php-env:5.6-apache $(OPTS) -f Dockerfile5.6-apache .
php7-apache: check generate7-apache
	docker build -t php-env:7-apache $(OPTS) -f Dockerfile7-apache .


show:
	docker images -a php-env; exit 0


clean:
	docker rmi --force `docker images -q php-env` 2> /dev/null; exit 0
	rm -f Dockerfile5.* Dockerfile7*; exit 0

