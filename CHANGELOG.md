## 4.4 2018-02-01  <daveconroy@selfdesign.org>

* Rebase

## 4.3 2018-01-29  <daveconroy@selfdesign.org>

* Add Zabbix Checks for Wordpress

## 4.2 2017-07-06  <daveconroy@selfdesign.org>

* Added PHP_TIMEOUT

## 4.1 2017-06-23 <daveconroy@selfdesign.org>

* Rebase to allow msmtp and sanity checks on init

## 4.0 2017-06-23 <daveconroy@selfdesign.org>

* Rebase from nginx-php-fpm
* Cleaned up drastically complexity


## 3.6 2017-06-13 <daveconroy@selfdesign.org>

* Added Git to Support VersionPress

## 3.5 2017-06-07 <daveconroy@selfdesign.org>

* Rebase to Alpine 3.6

## 3.4 2017-04-07 <daveconroy@selfdesign.org>

* Rebase Source Tree 

## 3.3 2017-03-29 <daveconroy@selfdesign.org>

* Added pdftk

## 3.0.2 2017-02-09 <daveconroy@selfdesign.org>

* Bugfixes with Zabbix
* Switched Base to local alpine:edge
* Removed Sed optimizations to support persistent configuration of nginx.conf

## 3.0.1 2017-02-07 <daveconroy@selfdesign.org>

* Added PHP OPCache Checks for Zabbix and Fixed some Variables

## 3.0 2017-02-07 <daveconroy@selfdesign.org>

* Added Zabbix Agent
* Zabbix Agent configured to check php-fpm and nginx


## 2.1 2017-01-28 <daveconroy@selfdesign.org>

* Added Nginx Rewrite Rules to support SimpleSAMLPHP 
* Added php7-ldap, openssl
* Removed Built in Redis Configuration - use external source from now on.


## 2.0 2017-01-16 <daveconroy@selfdesign.org>

* Major Cleanup - Removing Environment and Security Variables which required Root
* Automatically download Wordpress if not found in Persistent Storage
* Cleaned up Code and Documented Stages and Processes for Learning

## 1.0 2017-01-02 <daveconroy@selfdesign.org>

* Initial Release
* Alpine:edge
* PHP7
* wp-cli
* Must copy Wordpress Installation files to folder upon bootup
