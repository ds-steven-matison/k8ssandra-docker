from jmcarbo/nginx-php-fpm
COPY php.ini /etc/php5/fpm/php.ini
COPY www.conf /etc/php5/fpm/pool.d/www.conf
COPY . /usr/share/nginx/html

#FROM php:7.2-fpm
#RUN mkdir /app
#COPY . /app