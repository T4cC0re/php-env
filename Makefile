build: check generate php5.4 php5.5 php5.6 php7
rebuild: clean build
check: Dockerfile
	docker ps
generate: generate5.4 generate5.5 generate5.6 generate7
generate5.4: Dockerfile
	sed -r 's/php:[0-9]\.?[0-9]?/php:5.4/g' Dockerfile > Dockerfile5.4
generate5.5: Dockerfile
	sed -r 's/php:[0-9]\.?[0-9]?/php:5.5/g' Dockerfile > Dockerfile5.5
generate5.6: Dockerfile
	sed -r 's/php:[0-9]\.?[0-9]?/php:5.6/g' Dockerfile > Dockerfile5.6
generate7: Dockerfile
	sed -r 's/php:[0-9]\.?[0-9]?/php:7/g' Dockerfile > Dockerfile7
php5.4: check generate5.4
	docker build -t php-env:5.4 $(OPTS) -f Dockerfile5.4 .
php5.5: check generate5.5
	docker build -t php-env:5.5 $(OPTS) -f Dockerfile5.5 .
php5.6: check generate5.6
	docker build -t php-env:5.6 $(OPTS) -f Dockerfile5.6 .
php7: check generate7
	docker build -t php-env:7 $(OPTS) -f Dockerfile7 .
show:
	docker images -a php-env; exit 0
clean:
	docker rmi --force `docker images -q php-env` 2> /dev/null; exit 0
	rm -f Dockerfile5.* Dockerfile7; exit 0
install:
	echo "Todo. Install some scripts to have 'vitual-env'yness."

