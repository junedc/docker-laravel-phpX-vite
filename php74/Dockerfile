FROM php:7.4-fpm-alpine

RUN set -ex         && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS icu-dev zlib-dev libpng-dev libjpeg-turbo-dev freetype-dev oniguruma-dev libxml2-dev git         && docker-php-ext-install pdo_mysql bcmath intl gd         && pecl install xdebug-3.1.6 \
    && docker-php-ext-enable xdebug \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/*

COPY conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
