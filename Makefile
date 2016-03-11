build: check generate php5.4 php5.5 php5.6 php7
rebuild: clean build
check:
	docker ps
generate:
	sed -r 's/php:[0-9]\.?[0-9]?/php:5.4/g' Dockerfile > Dockerfile5.4
	sed -r 's/php:[0-9]\.?[0-9]?/php:5.5/g' Dockerfile > Dockerfile5.5
	sed -r 's/php:[0-9]\.?[0-9]?/php:5.6/g' Dockerfile > Dockerfile5.6
	sed -r 's/php:[0-9]\.?[0-9]?/php:7/g' Dockerfile > Dockerfile7
php5.4: Dockerfile5.4
	cat Dockerfile5.4 | docker build -t php-env:5.4 $(OPTS) -
php5.5: Dockerfile5.5
	cat Dockerfile5.5 | docker build -t php-env:5.5 $(OPTS) -
php5.6: Dockerfile5.6
	cat Dockerfile5.6 | docker build -t php-env:5.6 $(OPTS) -
php7: Dockerfile7
	cat Dockerfile7 | docker build -t php-env:7 $(OPTS) -
show:
	docker images -a php-env; exit 0
clean:
	docker rmi --force `docker images -q php-env` 2> /dev/null; exit 0
	rm -f Dockerfile{5.4,5.5,5.6,7} ; exit 0
install:
	echo "Todo. Install some scripts to have 'vitual-env'yness."

