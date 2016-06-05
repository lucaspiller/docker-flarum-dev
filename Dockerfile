FROM php:5-apache
RUN apt-get update
RUN apt-get install -y mariadb-client libpng-dev zip git
RUN docker-php-ext-install mbstring pdo_mysql gd

WORKDIR /var/www
RUN php -r "readfile('https://getcomposer.org/installer');" | php
RUN mkdir flarum
RUN a2enmod rewrite

COPY config/apache.conf /etc/apache2/sites-enabled/flarum.conf
COPY config/php.ini /usr/local/etc/php/php.ini
COPY entrypoint.sh /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
