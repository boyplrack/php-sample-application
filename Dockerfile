FROM php:7.1-apache

RUN apt-get update && apt-get install make wget git unzip -y
RUN a2enmod rewrite
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql
RUN git clone https://github.com/patrickallaert/php-sample-application.git
RUN make -C /var/www/html/php-sample-application/
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY /config-dev/db-connection.php /var/www/html/php-sample-application/config/db-connection.php
RUN chown www-data:www-data -R /var/www/html/php-sample-application
