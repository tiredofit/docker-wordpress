FROM docker.io/tiredofit/nginx-php-fpm:alpine-8.0
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

### Set Defaults
ENV PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_MYSQLI=TRUE \
    NGINX_WEBROOT="/www/wordpress" \
    IMAGE_NAME="tiredofit/wordpress" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-wordpress/"


RUN apk update && \
    apk upgrade && \
    \
### WP-CLI Installation
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp-cli && \
    chown nginx:www-data /usr/bin/wp-cli && \
    \
    rm -rf /var/cache/apk/*

### Add Files
ADD install/ /
