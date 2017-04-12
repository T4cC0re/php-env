.PHONY: build php php-cli php-apache rebuild clean Dockerfile Dockerfile-cli Dockerfile-apache show clean push phpv php5.4-cli php5.5-cli php5.6-cli php7-cli php5.4-apache php5.5-apache php5.6-apache php7-apache php7.1-apache php7.1-cli
APACHE1:=$(shell cat src/APACHE1)
APACHE2:=$(shell cat src/APACHE2)
APACHE3:=$(shell cat src/APACHE3)

build: check php

php: php-cli php-apache
legacy-php-cli: 5.2-cli 5.3-cli
php-cli: legacy-php-cli 5.4-cli 5.5-cli 5.6-cli 7-cli 7.1-cli
php-apache: php5.4-apache php5.5-apache php5.6-apache php7-apache php7.1-apache

rebuild: clean build


check: src/Dockerfile_BASE src/APACHE1 src/APACHE2 src/APACHE3
	@docker ps >/dev/null


Dockerfile: Dockerfile-cli Dockerfile-apache
Dockerfile-cli: Dockerfile5.4-cli Dockerfile5.5-cli Dockerfile5.6-cli Dockerfile7-cli Dockerfile7.1-cli
Dockerfile-apache: Dockerfile5.4-apache Dockerfile5.5-apache Dockerfile5.6-apache Dockerfile7-apache Dockerfile7.1-apache
5.2-cli: check 5.2.17-cli
5.3-cli: check 5.3.29-cli

5.2.%-cli 5.3.%-cli: check
	@export IMAGE="t4cc0re/legacy-php:$@"; cat src/Dockerfile_BASE | envsubst '$$IMAGE:$$APACHE1:$$APACHE2:$$APACHE3' | docker build -t t4cc0re/php-env:$@ --pull --no-cache --build-arg packages="git sudo subversion libmcrypt4 geoip-bin libmemcached5 libmemcachedutil0" $(OPTS) -

5.2-apache: 5.2-fail
5.3-apache: 5.3-fail
5.2.%-apache: 5.2-fail
5.3.%-apache: 5.3-fail

%-cli: check
	@export IMAGE="php:$@"; cat src/Dockerfile_BASE | envsubst '$$IMAGE:$$APACHE1:$$APACHE2:$$APACHE3' | docker build -t t4cc0re/php-env:$@ --pull --no-cache $(OPTS) -

%-apache: check
	@export IMAGE="php:$@"; export APACHE1='$(APACHE1)'; export APACHE2='$(APACHE2)'; export APACHE3='$(APACHE3)'; cat src/Dockerfile_BASE | envsubst '$$IMAGE:$$APACHE1:$$APACHE2:$$APACHE3' | docker build -t t4cc0re/php-env:$@ --pull --no-cache $(OPTS) -


%-fail:
	@echo "cannot make the requested target. There is no source image. ($@)"; exit 1;

show:
	@docker images -a t4cc0re/php-env; exit 0

clean:
	@docker rmi --force `docker images -q t4cc0re/php-env` 2> /dev/null;

push:
	@docker push t4cc0re/php-env

phpv:
	for image in `docker images t4cc0re/php-env --format '{{.Repository}}:{{.Tag}}'`; do echo -e "------------\n$${image}" 2>&1; docker run -it $${image} php -v; done

test:
	@set -o pipefail make phpv | grep "Unable to load" && exit 1 || exit 0;
