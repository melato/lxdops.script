#!/bin/sh

service mysql stop
chown mysql:mysql /var/lib/mysql /var/lib/mysql-log
mv /var/lib/mysql/ib_logfile* /var/lib/mysql-log/
cat >> /etc/mysql/my.cnf <<END
[mysqld]
skip-innodb_doublewrite
innodb_use_native_aio=0
innodb_use_atomic_writes=0

innodb_log_group_home_dir = /var/lib/mysql-log
bind-address		= 0.0.0.0
END

service mysql start
sudo mkdir /var/opt/DB
