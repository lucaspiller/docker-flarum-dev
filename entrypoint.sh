#!/bin/bash

if [ ! -f /var/www/flarum/flarum ]; then
  echo "** Installing Flarum"
  php /var/www/composer.phar create-project flarum/flarum /var/www/flarum --no-interaction --stability=beta --prefer-source
fi

chmod 0775 /var/www/flarum
chmod 0775 /var/www/flarum/assets
chmod 0775 /var/www/flarum/storage

exec "$@"
