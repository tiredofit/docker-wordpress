ARG PHP_BASE=8.0
ARG DISTRO="alpine"

FROM docker.io/tiredofit/nginx-php-fpm:${PHP_BASE}-${DISTRO}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_MYSQLI=TRUE \
    NGINX_WEBROOT="/www/wordpress" \
    NGINX_SITE_ENABLED="wordpress" \
    IMAGE_NAME="tiredofit/wordpress" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-wordpress/"

RUN source /assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    \
    curl -o /usr/bin/wp-cli https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/bin/wp-cli && \
    package cleanup

COPY install/ /
