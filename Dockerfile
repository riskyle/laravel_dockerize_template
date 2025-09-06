FROM php:8.2-fpm

WORKDIR /var/www

RUN apt-get update

RUN apt-get install -y \
    curl \
    git \
    unzip \
    zip \
    libpq-dev

RUN docker-php-ext-install pdo_pgsql pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN groupadd -g 1000 www && \
    useradd -u 1000 -ms /bin/bash -g www www

COPY . .

RUN composer install \
    --optimize-autoloader \
    --no-interaction

RUN composer dump-autoload --optimize

RUN chown -R www:www /var/www && \
    chmod -R 755 /var/www && \
    chmod -R 775 storage bootstrap/cache || mkdir -p storage bootstrap/cache && chmod -R 775 storage bootstrap/cache

RUN mkdir -p storage/logs storage/framework/{cache,sessions,views} bootstrap/cache

RUN chown -R www:www storage bootstrap/cache && \
    chmod -R 775 storage bootstrap/cache

USER www

EXPOSE 9000
CMD ["php-fpm"]