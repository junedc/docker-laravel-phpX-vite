FROM php:8.3-fpm-bullseye

RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxml2-dev \
    libzip-dev zlib1g-dev libicu-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) pdo_mysql bcmath gd intl zip pcntl && \
    pecl install xdebug && docker-php-ext-enable xdebug && \
    echo "xdebug.start_with_request=\${XDEBUG_START_WITH_REQUEST:-no}" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# WORKDIR /var/www
