FROM nginx:alpine

LABEL maintainer="Yansell Rivas <yansellrivasdiaz@gmail.com>"

RUN apk update \
  && apk upgrade \
  # && apk add --no-cache openssl \
  && apk add --no-cache bash \
  && rm /var/cache/apk/* \
  && rm /etc/nginx/conf.d/default.conf
  # && adduser -D -H -u 1000 -s /bin/bash www-data

ENV PHP_UPSTREAM_CONTAINER=php-fpm
ENV PHP_UPSTREAM_PORT=9000

COPY conf.d/*.conf /etc/nginx/conf.d/
COPY conf.d/cors_settings  /etc/nginx/conf.d/
COPY ./startup.sh /opt/startup.sh
COPY nginx.conf /etc/nginx/

WORKDIR /var/www/html
VOLUME /var/www/html 

CMD ["/bin/bash", "/opt/startup.sh"]

EXPOSE 80
