## 4.3 2017-08-29 <dave at tiredofit dot ca>

* Cleaned up File System, added sanity checks
* New Base

## 4.2 2017-07-06  <dave at tiredofit dot ca>

* Added PHP_TIMEOUT

## 4.1 2017-06-23 <dave at tiredofit dot ca>

* Rebase to allow msmtp and sanity checks on init

## 4.0 2017-06-23 <dave at tiredofit dot ca>

* Rebase from nginx-php-fpm
* Cleaned up drastically complexity


## 3.6 2017-06-13 <dave at tiredofit dot ca>

* Added Git to Support VersionPress

## 3.5 2017-06-07 <dave at tiredofit dot ca>

* Rebase to Alpine 3.6

## 3.4 2017-04-07 <dave at tiredofit dot ca>

* Rebase Source Tree 

## 3.3 2017-03-29 <dave at tiredofit dot ca>

* Added pdftk

## 3.0.2 2017-02-09 <dave at tiredofit dot ca>

* Bugfixes with Zabbix
* Switched Base to local alpine:edge
* Removed Sed optimizations to support persistent configuration of nginx.conf

## 3.0.1 2017-02-07 <dave at tiredofit dot ca>

* Added PHP OPCache Checks for Zabbix and Fixed some Variables

## 3.0 2017-02-07 <dave at tiredofit dot ca>

* Added Zabbix Agent
* Zabbix Agent configured to check php-fpm and nginx


## 2.1 2017-01-28 <dave at tiredofit dot ca>

* Added Nginx Rewrite Rules to support SimpleSAMLPHP 
* Added php7-ldap, openssl
* Removed Built in Redis Configuration - use external source from now on.


## 2.0 2017-01-16 <dave at tiredofit dot ca>

* Major Cleanup - Removing Environment and Security Variables which required Root
* Automatically download Wordpress if not found in Persistent Storage
* Cleaned up Code and Documented Stages and Processes for Learning

## 1.0 2017-01-02 <dave at tiredofit dot ca>

* Initial Release
* Alpine:edge
* PHP7
* wp-cli
* Must copy Wordpress Installation files to folder upon bootup
