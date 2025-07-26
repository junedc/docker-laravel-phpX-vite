FROM ghcr.io/railwayapp/php:8.3-fpm-alpine

# Install build deps & common PHP extensions
RUN set -ex         && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS icu-dev zlib-dev libpng-dev libjpeg-turbo-dev freetype-dev oniguruma-dev libxml2-dev git         && docker-php-ext-install pdo_mysql bcmath intl gd         # Xdebug
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    # Clean up
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/*

COPY conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
