FROM tiredofit/nginx-php-fpm:7.3-latest
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Dependency Installation
  RUN apk update && \
      apk upgrade && \
      apk add \
          git \
          mysql-client \
          pdftk \
          python2 \
          && \
      \
      rm -rf /var/cache/apk/* && \
      \
### WP-CLI Installation
      curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp-cli && chown nginx:nginx /usr/bin/wp-cli

### Add Files
  ADD install/ /
