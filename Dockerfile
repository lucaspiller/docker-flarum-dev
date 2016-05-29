FROM php:5-apache
RUN apt-get update
RUN apt-get install -y mariadb-client libpng-dev zip git
RUN docker-php-ext-install mbstring pdo_mysql gd

WORKDIR /var/www
RUN php -r "readfile('https://getcomposer.org/installer');" | php
RUN mkdir flarum; cd flarum; php ../composer.phar create-project flarum/flarum . --no-interaction --stability=beta --prefer-source
ADD config/apache.conf /etc/apache2/sites-enabled/flarum.conf
RUN chown -R www-data:www-data flarum
RUN a2enmod rewrite

EXPOSE 80
CMD apache2-foreground
