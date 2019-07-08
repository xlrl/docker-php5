FROM alpine:3.8
MAINTAINER Alexander Mueller <XelaRellum@web.de>

RUN apk update --no-cache

RUN apk upgrade --no-cache

RUN apk add --no-cache \
    php5 php5-fpm php5-mysqli \
    nginx supervisor

RUN set -xe && \
    mkdir -p /run/nginx && \
    mkdir -p /var/www

ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisord.conf /etc/supervisord.conf
ADD start.sh /start.sh
ADD www.conf /etc/php5/fpm.d/www.conf

# RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php7/php-fpm.ini && \

#     sed -i -e "s|;daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
#RUN \
#    sed -i -e "s|listen\s*=\s*127\.0\.0\.1:9000|listen = /var/run/php-fpm5.sock|g" /etc/php5/php-fpm.d/www.conf && \
#    sed -i -e "s|;listen\.owner\s*=\s*|listen.owner = |g" /etc/php5/php-fpm.d/www.conf && \
#    sed -i -e "s|;listen\.group\s*=\s*|listen.group = |g" /etc/php5/php-fpm.d/www.conf && \
#    sed -i -e "s|;listen\.mode\s*=\s*|listen.mode = |g" /etc/php5/php-fpm.d/www.conf && \
RUN \
    chmod +x /start.sh

EXPOSE 80
VOLUME ["/var/www"]

CMD /start.sh
