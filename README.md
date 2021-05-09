# github.com/tiredofit/docker-wordpress

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-wordpress?style=flat-square)](https://github.com/tiredofit/docker-wordpress/releases/latest)
[![Build Status](https://img.shields.io/github/workflow/status/tiredofit/docker-wordpress/build?style=flat-square)](https://github.com/tiredofit/docker-wordpress/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/wordpress.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/wordpress/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/wordpress.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/wordpress/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)
## About

This will build a Docker Image for [Wordpress](https://www.wordpress.org/). A web based content management system. It will:

* Automatically Download latest version of Wordpress
* Configure `wp-config.php` for you
* Install Database
* Configure the website with basic information
* Automatically rotate URLs accordingly.
* Includes [WP-CLI](http://wp-cli.org/)

## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [Introduction](#introduction)
- [Authors](#authors)
- [Table of Contents](#table-of-contents)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Quick Start](#quick-start)
- [Configuration](#configuration)
  - [Data-Volumes](#data-volumes)
  - [Database](#database)
  - [Environment Variables](#environment-variables)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
  - [Local Development / Changing Site Name & Ports](#local-development--changing-site-name--ports)
  - [Command Line](#command-line)
- [References](#references)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)

## Installation

### Build from Source
Clone this repository and build the image with `docker build <arguments> (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/wordpress) and is the recommended method of installation.

```bash
docker pull tiredofit/wordpress:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| PHP version | OS     | Tag        |
| ----------- | ------ | ---------- |
| 8.0.x       | Alpine | `:php-8.0` |
| 7.4.x       | Alpine | `:php-7.4` |
| 7.3.x       | Alpine | `:php-7.3` |
| 7.2.x       | Alpine | `:php-7.2` |
| 7.1.x       | Alpine | `:php-7.1` |
| 7.0.x       | Alpine | `:php-7.0` |
| 5.6.x       | Alpine | `:php5.6`  |

#### Multi Archictecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v6`, `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`


## Configuration
### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory        | Description                |
| ---------------- | -------------------------- |
| `/www/wordpress` | Root Wordpress Directory   |
| `/www/logs`      | Nginx and php-fpm logfiles |

### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                         | Description                            |
| ------------------------------------------------------------- | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/)        | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)           | Nginx webserver                        |
| [PHP-FPM](https://github.com/tiredofit/docker-nginx-php-fpm/) | PHP Interpreter                        |

| Parameter                    | Description                                                                                                       | Default            |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------------------ |
| `ADMIN_EMAIL`                | Email address for the Administrator - Needed to run                                                               |                    |
| `ADMIN_USER`                 | Username for the Administrator                                                                                    | `admin`            |
| `ADMIN_PASS`                 | Password for the Administrator - Needed to run                                                                    |                    |
| `ENABLE_HTTPS_REVERSE_PROXY` | Tweak nginx to run behind a reverse proxy for URLs `TRUE` / `FALSE`                                               | `TRUE`             |
| `DB_CHARSET`                 | MariaDB character set for tables                                                                                  | `utf8mb4`          |
| `DB_HOST`                    | MariaDB external container hostname (e.g. wordpress-db)                                                           |                    |
| `DB_NAME`                    | MariaDB database name i.e. (e.g. wordpress)                                                                       |                    |
| `DB_USER`                    | MariaDB username for database (e.g. wordpress)                                                                    |                    |
| `DB_PASS`                    | MariaDB password for database (e.g. userpassword)                                                                 |                    |
| `DB_PREFIX`                  | MariaDB Prefix for `DB_NAME`                                                                                      | `wp_`              |
| `DEBUG_MODE`                 | Enable Debug Mode (verbosity) for the container installation/startup and in application - `TRUE` / `FALSE`        | `FALSE`            |
| `SITE_LOCALE`                | What Locale to set site                                                                                           | `en_US`            |
| `SITE_PORT`                  | What Port does wordpress deliver assets to                                                                        | `80`               |
| `SITE_TITLE`                 | The title of the Website                                                                                          | `Docker Wordpress` |
| `SITE_URL`                   | The Full site URL of the installation e.g. `wordpress.example.com` - Required for Install                         |                    |
| `SITE_URL_UPDATE_MODE`       | After first install, perform modifications to wp-config.php and DB if different Site URL `FILE` `DB` `ALL` `NONE` | `ALL`              |


### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

* * *
## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```
### Local Development / Changing Site Name & Ports

Wordpress assets are delivered by means of the initial Site URL, and if you wish to develop locally or on a different port you will experience strange results. If you are performing local development then you would want to setup your environment variables as such:

- `ENABLE_HTTPS_REVERSE_PROXY=FALSE`
- `SITE_URL=localhost`
- `SITE_PORT=8000` (or whatever port you are exposing)

When you are ready to deploy to a production URL - you would change it as such:
- `ENABLE_HTTPS_REVERSE_PROXY=TRUE`
- `SITE_URL=www.domain.com`

The system will rotate the URLs in the wordpress configuration files and database automatically upon restart of the container.

### Command Line

If you wish to use the included wp-cli tool to perform maintenance use it as such:

````bash
cd /www/wordpress
wp-cli <argument>
````

## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.
## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. wordpress) bash
```

## References

* https://www.wordpress.org
* http://www.wp-cli.org
