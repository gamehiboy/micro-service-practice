#!/bin/bash
set -eux
env

# mysql init
cd ${APP_PATH}/build-depends/mysql-conf/ && ./mysql_init.sh

# start supervisord nodaemon
cp ${APP_PATH}/supervisor.conf.d/*.conf /etc/supervisor/conf.d/
/usr/bin/supervisord --nodaemon

