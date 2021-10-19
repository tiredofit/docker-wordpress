FROM docker.io/tiredofit/nginx-php-fpm:alpine-8.0
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

### Set Defaults
ENV PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_MYSQLI=TRUE \
    NGINX_WEBROOT="/www/wordpress" \
    CONTAINER_NAME=wordpress-app

### Dependency Installation
RUN apk update && \
    apk upgrade && \
    apk add -t .wordpress-run-deps \
               python2 \
               && \
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
