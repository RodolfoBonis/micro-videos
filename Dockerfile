FROM php:7.3.6-fpm-alpine3.9

RUN apk add --no-cache \
    zip \
    libzip-dev \
    libpng \
    libpng-dev \
    libjpeg \
    icu \
    icu-dev \
    libxml2 \
    libxml2-dev \
    git \
    openssl \
    openssl-dev \
    shadow \
    bash \
    mysql-client \
    nodejs \
    npm
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    mbstring \
    intl \
    xml \
    opcache \
    pcntl \
    bcmath \
    zip \
    soap

RUN apk add --no-cache libwebp-dev libjpeg-turbo-dev libpng-dev libxpm-dev freetype-dev

RUN docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
    --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir

RUN docker-php-ext-install gd

RUN apk add --no-cache $PHPIZE_DEPS

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.discover_client_host=true" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=\"DEBUG\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini




RUN curl -sS https://getcomposer.org/installer | php ; mv composer.phar /usr/local/bin/composer;
RUN composer global require laravel/installer
ENV PATH="/root/.composer/vendor/bin:${PATH}"

RUN apk add --update nodejs
RUN apk add --update npm
RUN apk add yarn

RUN apk add --update tzdata
ENV TZ=America/Sao_Paulo


RUN touch /home/www-data/.bashrc | echo "PS1='\w\$ '" >> /home/www-data/.bashrc

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN usermod -u 1000 www-data

WORKDIR /var/www

RUN rm -rf /var/www/html && ln -s public html

USER www-data

EXPOSE 9000
