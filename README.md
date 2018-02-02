# registry.selfdesign.org/docker/wordpress

# Introduction

Dockerfile to build a [Wordpress](https://www.wordpress.org/) container image.

It will automatically download the latest wordpress release upon build, and if you have set correct environment variables, will autocreate a database if you wish.

This Container uses Alpine:Edge as a base.
Additional Components are PHP7 w/ APC, OpCache, Support - [WP-CLI](http://wp-cli.org/) and MySQL Client is also available.


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

This image relies on an external MySQL Server, external SMTP Server, and is meant to be run behind a reverse SSL Proxy such as nginx-proxy.


# Installation

Automated builds of the image are available on [Registry](https://registry.selfdesign.org/docker/wordpress) and is the recommended method of installation.


```bash
docker pull registry.selfdesign.org/docker/wordpress
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
| `PHP_MEMORY_LIMIT` |Amount of memory php-fpm process should use (Default 128M) |
| `UPLOAD_MAX_SIZE` | Maximum Upload Size: (Default 2G) |
| `APC_SHM_SIZE` | PHP7 APC SHM Cache Size: (Default 128M) |
| `OPCACHE_MEM_SIZE` | PHP7 OPCache Size (Default 128) |
| `TZ` | Timezone - Use Unix Timezone format (Default America/Vancouver) |
| `DB_HOST` | MySQL external container hostname (e.g. wordpress1-db)
| `DB_NAME` | MySQL database name i.e. (e.g. wordpress)
| `DB_USER` | MySQL username for database (e.g. wordpress)
| `DB_PASS` | MySQL password for database (e.g. userpassword)


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

