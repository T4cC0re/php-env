.PHONY: build php php-cli php-apache rebuild clean Dockerfile Dockerfile-cli Dockerfile-apache show clean push phpv php5.4-cli php5.5-cli php5.6-cli php7-cli php5.4-apache php5.5-apache php5.6-apache php7-apache php7.1-apache php7.1-cli

build: check Dockerfile php


php: php-cli php-apache
php-cli: php5.4-cli php5.5-cli php5.6-cli php7-cli php7.1-cli
php-apache: php5.4-apache php5.5-apache php5.6-apache php7-apache php7.1-apache


rebuild: clean build


check: src/Dockerfile_BASE src/APACHE1 src/APACHE2 src/APACHE3
	@docker ps >/dev/null


Dockerfile: Dockerfile-cli Dockerfile-apache
Dockerfile-cli: Dockerfile5.4-cli Dockerfile5.5-cli Dockerfile5.6-cli Dockerfile7-cli Dockerfile7.1-cli
Dockerfile-apache: Dockerfile5.4-apache Dockerfile5.5-apache Dockerfile5.6-apache Dockerfile7-apache Dockerfile7.1-apache

Dockerfile5.4-cli: check
	@sed -r 's/%IMAGE%/php:5.4-cli/g' src/Dockerfile_BASE > Dockerfile5.4-cli
	@sed -ri 's/%APACHE1%//g' Dockerfile5.4-cli
	@sed -ri 's/%APACHE2%//g' Dockerfile5.4-cli
	@sed -ri 's/%APACHE3%//g' Dockerfile5.4-cli
Dockerfile5.5-cli: check
	@sed -r 's/%IMAGE%/php:5.5-cli/g' src/Dockerfile_BASE > Dockerfile5.5-cli
	@sed -ri 's/%APACHE1%//g' Dockerfile5.5-cli
	@sed -ri 's/%APACHE2%//g' Dockerfile5.5-cli
	@sed -ri 's/%APACHE3%//g' Dockerfile5.5-cli
Dockerfile5.6-cli: check
	@sed -r 's/%IMAGE%/php:5.6-cli/g' src/Dockerfile_BASE > Dockerfile5.6-cli
	@sed -ri 's/%APACHE1%//g' Dockerfile5.6-cli
	@sed -ri 's/%APACHE2%//g' Dockerfile5.6-cli
	@sed -ri 's/%APACHE3%//g' Dockerfile5.6-cli
Dockerfile7-cli: check
	@sed -r 's/%IMAGE%/php:7.0-cli/g' src/Dockerfile_BASE > Dockerfile7-cli
	@sed -ri 's/%APACHE1%//g' Dockerfile7-cli
	@sed -ri 's/%APACHE2%//g' Dockerfile7-cli
	@sed -ri 's/%APACHE3%//g' Dockerfile7-cli
Dockerfile7.1-cli: check
	@sed -r 's/%IMAGE%/php:7.1-cli/g' src/Dockerfile_BASE > Dockerfile7.1-cli
	@sed -ri 's/%APACHE1%//g' Dockerfile7.1-cli
	@sed -ri 's/%APACHE2%//g' Dockerfile7.1-cli
	@sed -ri 's/%APACHE3%//g' Dockerfile7.1-cli
Dockerfile5.4-apache: check
	@sed 's/%IMAGE%/php:5.4-apache/g' src/Dockerfile_BASE > Dockerfile5.4-apache
	@sed -i "/%APACHE1%/r src/APACHE1" Dockerfile5.4-apache
	@sed -i "s/%APACHE1%//g" Dockerfile5.4-apache
	@sed -i "/%APACHE2%/r src/APACHE2" Dockerfile5.4-apache
	@sed -i "s/%APACHE2%//g" Dockerfile5.4-apache
	@sed -i "/%APACHE3%/r src/APACHE3" Dockerfile5.4-apache
	@sed -i "s/%APACHE3%//g" Dockerfile5.4-apache
Dockerfile5.5-apache: check
	@sed -r 's/%IMAGE%/php:5.5-apache/g' src/Dockerfile_BASE > Dockerfile5.5-apache
	@sed -i "/%APACHE1%/r src/APACHE1" Dockerfile5.5-apache
	@sed -i "s/%APACHE1%//g" Dockerfile5.5-apache
	@sed -i "/%APACHE2%/r src/APACHE2" Dockerfile5.5-apache
	@sed -i "s/%APACHE2%//g" Dockerfile5.5-apache
	@sed -i "/%APACHE3%/r src/APACHE3" Dockerfile5.5-apache
	@sed -i "s/%APACHE3%//g" Dockerfile5.5-apache
Dockerfile5.6-apache: check
	@sed -r 's/%IMAGE%/php:5.6-apache/g' src/Dockerfile_BASE > Dockerfile5.6-apache
	@sed -i "/%APACHE1%/r src/APACHE1" Dockerfile5.6-apache
	@sed -i "s/%APACHE1%//g" Dockerfile5.6-apache
	@sed -i "/%APACHE2%/r src/APACHE2" Dockerfile5.6-apache
	@sed -i "s/%APACHE2%//g" Dockerfile5.6-apache
	@sed -i "/%APACHE3%/r src/APACHE3" Dockerfile5.6-apache
	@sed -i "s/%APACHE3%//g" Dockerfile5.6-apache
Dockerfile7-apache: check
	@sed -r 's/%IMAGE%/php:7.0-apache/g' src/Dockerfile_BASE > Dockerfile7-apache
	@sed -i "/%APACHE1%/r src/APACHE1" Dockerfile7-apache
	@sed -i "s/%APACHE1%//g" Dockerfile7-apache
	@sed -i "/%APACHE2%/r src/APACHE2" Dockerfile7-apache
	@sed -i "s/%APACHE2%//g" Dockerfile7-apache
	@sed -i "/%APACHE3%/r src/APACHE3" Dockerfile7-apache
	@sed -i "s/%APACHE3%//g" Dockerfile7-apache
Dockerfile7.1-apache: check
	@sed -r 's/%IMAGE%/php:7.1-apache/g' src/Dockerfile_BASE > Dockerfile7.1-apache
	@sed -i "/%APACHE1%/r src/APACHE1" Dockerfile7.1-apache
	@sed -i "s/%APACHE1%//g" Dockerfile7.1-apache
	@sed -i "/%APACHE2%/r src/APACHE2" Dockerfile7.1-apache
	@sed -i "s/%APACHE2%//g" Dockerfile7.1-apache
	@sed -i "/%APACHE3%/r src/APACHE3" Dockerfile7.1-apache
	@sed -i "s/%APACHE3%//g" Dockerfile7.1-apache

php5.4-cli: check Dockerfile5.4-cli
	docker build -t t4cc0re/php-env:5.4-cli $(OPTS) -f Dockerfile5.4-cli .

php5.5-cli: check Dockerfile5.5-cli
	docker build -t t4cc0re/php-env:5.5-cli $(OPTS) -f Dockerfile5.5-cli .

php5.6-cli: check Dockerfile5.6-cli
	docker build -t t4cc0re/php-env:5.6-cli $(OPTS) -f Dockerfile5.6-cli .
	docker tag t4cc0re/php-env:5.6-cli t4cc0re/php-env:5-cli

php7-cli: check Dockerfile7-cli
	docker build -t t4cc0re/php-env:7.0-cli $(OPTS) -f Dockerfile7-cli .
	docker tag t4cc0re/php-env:7.0-cli t4cc0re/php-env:7-cli

php7.1-cli: check Dockerfile7.1-cli
	docker build -t t4cc0re/php-env:7.1-cli $(OPTS) -f Dockerfile7.1-cli .

php5.4-apache: check Dockerfile5.4-apache
	docker build -t t4cc0re/php-env:5.4-apache $(OPTS) -f Dockerfile5.4-apache .

php5.5-apache: check Dockerfile5.5-apache
	docker build -t t4cc0re/php-env:5.5-apache $(OPTS) -f Dockerfile5.5-apache .

php5.6-apache: check Dockerfile5.6-apache
	docker build -t t4cc0re/php-env:5.6-apache $(OPTS) -f Dockerfile5.6-apache .
	docker tag t4cc0re/php-env:5.6-apache t4cc0re/php-env:5-apache

php7-apache: check Dockerfile7-apache
	docker build -t t4cc0re/php-env:7.0-apache $(OPTS) -f Dockerfile7-apache .
	docker tag t4cc0re/php-env:7.0-apache t4cc0re/php-env:7-apache

php7.1-apache: check Dockerfile7.1-apache
	docker build -t t4cc0re/php-env:7.1-apache $(OPTS) -f Dockerfile7.1-apache .


show:
	@docker images -a t4cc0re/php-env; exit 0


clean:
	@docker rmi --force `docker images -q t4cc0re/php-env` 2> /dev/null; exit 0
	@rm -f Dockerfile5.* Dockerfile7*; exit 0

push:
	@docker push t4cc0re/php-env

phpv:
	docker run -it t4cc0re/php-env:5.4-cli php -v
	docker run -it t4cc0re/php-env:5.5-cli php -v
	docker run -it t4cc0re/php-env:5.6-cli php -v
	docker run -it t4cc0re/php-env:7-cli php -v
	docker run -it t4cc0re/php-env:7.1-cli php -v
