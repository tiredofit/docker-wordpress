# hub.docker.com/r/tiredofit/wordpress

[![Build Status](https://img.shields.io/docker/build/tiredofit/wordpress.svg)](https://hub.docker.com/r/tiredofit/wordpress)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/wordpress.svg)](https://hub.docker.com/r/tiredofit/wordpress)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/wordpress.svg)](https://hub.docker.com/r/tiredofit/wordpress)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/wordpress.svg)](https://microbadger.com/images/tiredofit/wordpress)

## Introduction

Dockerfile to build a [Wordpress](https://www.wordpress.org/) container image.

It will:

* Automatically Download latest version of Wordpress
* Configure `wp-config.php` for you
* Install Database
* Configure the website with basic information
* If your initial URL changes, automatically rotate URLs accordingly.
* Includes [WP-CLI](http://wp-cli.org/)

* This Container uses a [customized Alpine Linux base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, mariadb-client, nano, vim) for easier management. It also supports sending to external SMTP servers..

[Changelog](CHANGELOG.md)

## Authors

- [Dave Conroy](dave at tiredofit dot ca)

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

## Prerequisites
This image assumes that you are using a reverse proxy such as [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy Companion @ https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) or [tiredofit/traefik](https://github.com/tiredofit/docker-traefik) in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports.

This image relies on an external MariaDB Server, external SMTP Server, and is meant to be run behind a reverse SSL Proxy such as nginx-proxy.

## Installation

Automated builds of the image are available on [Registry](https://hub.docker.rom/r/tiredofit/wordpress) and is the recommended method of installation.

```bash
docker pull tiredofit/wordpress:latest
```

Also check out the builds in Docker Hub, you may find builds that work under different PHP versions however this is not guaranteed.

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

## Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
|-----------|-------------|
| `/www/wordpress` | Root Wordpress Directory |
| `/www/logs` | Nginx and php-fpm logfiles |

### Database

This container requires the usage of an external database. Set one up accordingly. Recommend that you use [tiredofit/mariadb](https://github.com/tiredofit/docker-mariadb) or set one up manually like so:

```sql
CREATE USER 'wordpress'@'%.%.%.%' IDENTIFIED BY 'password';
CREATE DATABASE IF NOT EXISTS `wordpress` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;
GRANT ALL PRIVILEGES ON `wordpress`.* TO 'wordpress'@'%.%.%.%';
```

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), and the [Nginx+PHP-FPM Engine](https://hub.docker.com/r/tiredofit/nginx-php-fpm) below is the complete list of available options that can be used to customize your installation.


| Parameter | Description |
|-----------|-------------|
| `ADMIN_EMAIL` | Email address for the Administrator - Needed to run   |
| `ADMIN_USER` | Username for the Administrator - Default `admin`       |
| `ADMIN_PASS` | Password for the Administrator - Needed to run         |
| `ENABLE_HTTPS_REVERSE_PROXY` | Tweak nginx to run behind a reverse proxy for URLs `TRUE` / `FALSE` - Default `TRUE` |
| `DB_CHARSET` MariaDB character set for tables - Default `utf8mb4` |
| `DB_HOST` | MariaDB external container hostname (e.g. wordpress-db) |
| `DB_NAME` | MariaDB database name i.e. (e.g. wordpress) |
| `DB_USER` | MariaDB username for database (e.g. wordpress) |
| `DB_PASS` | MariaDB password for database (e.g. userpassword) |
| `DB_PREFIX` | MariaDB Prefix for `DB_NAME` - Default `wp_`             |
| `DEBUG_MODE` | Enable Debug Mode (verbosity) for the container installation/startup and in application - `TRUE` / `FALSE` - Default `FALSE` |
| `SITE_LOCALE` | What Locale to set site - Default `en_US`             |
| `SITE_PORT` | What Port does wordpress deliver assets to - Default `80` |
| `SITE_TITLE` | The title of the Website - Default `Docker Wordpress`  |
| `SITE_URL` | The Full site URL of the installation e.g. `wordpress.example.com` - Required for Install |
| `SITE_URL_UPDATE_MODE` | After first install, perform modifications to wp-config.php and DB if different Site URL `FILE` `DB` `ALL` `NONE` - Default `ALL` |


### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `80`      | HTTP        |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. wordpress) bash
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
sudo -u nginx wp-cli <argument>
````

## References

* https://www.wordpress.org
* http://www.wp-cli.org
