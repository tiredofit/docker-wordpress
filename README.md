# tiredofit/wordpress

# Introduction

Dockerfile to build a [Wordpress](https://www.wordpress.org/) container image.

It will automatically download the latest wordpress release upon build, and if you have set correct environment variables, will autocreate a database if you wish.

Dockerfile to build a [Nextcloud](https://nextcloud.com) container image.

* This Container uses a [customized Alpine Linux base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) based on TRUNK compiled for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, mariadb-client, nano, vim) for easier management. It also supports sending to external SMTP servers..

* Also includes WP-CLI](http://wp-cli.org/)


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](dave at tiredofit dot ca)

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Database](#database)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

# Prerequisites

This image relies on an external MariaDB Server, external SMTP Server, and is meant to be run behind a reverse SSL Proxy such as nginx-proxy.


# Installation

Automated builds of the image are available on [Registry](https://hub.docker.rom/r/tiredofit/wordpress) and is the recommended method of installation.

```bash
docker pull tiredofit/wordpress
```

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

# Configuration

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
| `ENABLE_HTTPS_REVERSE_PROXY` | Tweak nginx to run behind a reverse proxy for URLs | 
| `DB_HOST` | MySQL external container hostname (e.g. wordpress1-db)
| `DB_NAME` | MySQL database name i.e. (e.g. wordpress)
| `DB_USER` | MySQL username for database (e.g. wordpress)
| `DB_PASS` | MySQL password for database (e.g. userpassword)

* The DB Variables are unused at this time except to check that your remote DB is available. At some point in time there would have been an automated image to perform a hands-free setup, however I moved onto other things.

### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `80` | HTTP |

# Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. wordpress) bash
```

# References

* https://www.wordpress.org
* http://www.wp-cli.org
