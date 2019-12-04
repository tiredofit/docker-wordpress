FROM tiredofit/nginx-php-fpm:7.0
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Set Defaults
ENV PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_MYSQLI=TRUE \
    NGINX_WEBROOT="/www/wordpress" \
    ZABBIX_HOSTNAME=wordpress-app

### Dependency Installation
RUN apk update && \
    apk upgrade && \
    \
### WP-CLI Installation
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp-cli && \
    chown nginx:www-data /usr/bin/wp-cli && \
    \
### Cleanup
    rm -rf /var/cache/apk/*

### Add Files
ADD install/ /
