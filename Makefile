SHELL := /bin/bash

.PHONY: certs up down restart xon xoff logs composer-install composer-install-php74 npm-install migrate migrate-php74

certs:
	mkcert -install && mkcert playground.test cruzes.test viteme.test oldphp.test \
	&& mv playground.test+4.pem docker/certs/dev.crt \
	&& mv playground.test+4-key.pem docker/certs/dev.key

up:
	docker compose up -d --build

down:
	docker compose down

restart:
	docker compose restart

# Enable Xdebug (develop+debug) and restart PHP containers
xon:
	XDEBUG_MODE=develop,debug XDEBUG_START_WITH_REQUEST=yes docker compose up -d --build php83 php74

# Disable Xdebug (mode=off) and restart PHP containers
xoff:
	XDEBUG_MODE=off XDEBUG_START_WITH_REQUEST=no docker compose up -d --build php83 php74

logs:
	docker compose logs -f

composer-install:
	docker compose exec php83 bash -lc "cd playground && composer install"; \
	docker compose exec php83 bash -lc "cd cruzes && composer install"

composer-install-php74:
	docker compose exec php74 sh -lc "composer install --ignore-platform-reqs"

npm-install:
	docker compose exec viteme sh -lc "npm install"

migrate:
	docker compose exec php83 bash -lc "cd playground && php artisan migrate --seed"; \
	docker compose exec php83 bash -lc "cd cruzes && php artisan migrate --seed"

migrate-php74:
	docker compose exec php74 bash -lc "cd php74 && php artisan migrate --seed"
