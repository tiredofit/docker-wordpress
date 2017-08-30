# hub.docker.com/tiredofit/wordpress

# Introduction

Dockerfile to build a [Wordpress](https://www.wordpress.org/) container image.

* It will automatically download the latest wordpress release upon build, and if you have set correct environment variables, will autocreate a database if you wish.

* This Container uses a [customized Alpine Linux base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) based on TRUNK compiled for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, mariadb-client, nano, vim) for easier management. It also supports sending to external SMTP servers..

* Additional Components are PHP7 w/ APC, OpCache, Support - [WP-CLI](http://wp-cli.org/) and MySQL Client is also available.


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](daveconroy@selfdesign.org) [https://git.selfdesign.org/daveconroy]

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

This image assumes that you are using a reverse proxy such as [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and optionally the [Let's Encrypt Proxy Companion @ https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) in order to serve your pages. However, it will run just fine on it's own if you map appropriate ports.

This image relies on an external MySQL Server, external SMTP Server.


# Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/tiredofit/wordpress) and is the recommended method of installation.


```bash
docker pull tiredofit/wordpress
```

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

# Configuration

### Data-Volumes

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), and the [Nginx+PHP-FPM Engine](https://hub.docker.com/r/tiredofit/nginx-php-fpm) below is the complete list of available options that can be used to customize your installation.

| Directory | Description |
|-----------|-------------|
| `/www/wordpress` | Root Wordpress Directory |
| `/www/logs` | Nginx and php-fpm logfiles |

### Database

This container requires the usage of an external database. Set one up accordingly.

```sql
CREATE USER 'wordpress'@'%.%.%.%' IDENTIFIED BY 'password';
CREATE DATABASE IF NOT EXISTS `wordpress` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;
GRANT ALL PRIVILEGES ON `wordpress`.* TO 'wordpress'@'%.%.%.%';
```

### Environment Variables

Below is the complete list of available options that can be used to customize your installation.

| Parameter | Description |
|-----------|-------------|
| `DB_HOST` | MySQL external container hostname e.g. `wordpress1-db` | 
| `DB_NAME` | MySQL database name e.g. `wordpress` |
| `DB_USER` | MySQL username for database e.g. `wordpress` |
| `DB_PASS` | MySQL password for database e.g. `userpassword` |


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

