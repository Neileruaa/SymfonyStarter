
FROM php:7.3-apache

RUN apt-get update;apt-get install -y git zip unzip apt-utils nodejs npm
RUN npm install npm@latest -g
RUN docker-php-ext-install pdo_mysql
COPY ./docker/php/php.ini /usr/local/etc/php/
COPY ./docker/apache/default.conf /etc/apache2/sites-available/000-default.conf
COPY . /var/www/html/
RUN mkdir -p /var/www/html/public/uploads/annales && chmod -R 777 /var/www/html/public/uploads/annales
RUN mkdir -p /var/www/.cache && chown www-data /var/www/.cache && chgrp www-data /var/www/.cache
RUN mkdir -p /var/www/.config && chown www-data /var/www/.config && chgrp www-data /var/www/.config

WORKDIR /var/www/html

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

RUN composer install


RUN npm install

#RUN rm -rf /var/www/html/var/cache/*; chmod -R 777 /var/www/html/var; chmod -R 777 /var/www/html/data



#RUN rm -rf /var/www/html/var/cache/*; chmod -R 777 /var/www/html/var; chmod -R 777 /var/www/html/data
EXPOSE 80