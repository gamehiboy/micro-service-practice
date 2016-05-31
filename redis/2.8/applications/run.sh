#!/bin/bash
set -eux
env

# redis-server init
cd ${APP_PATH}/build-depends/redis-conf/ && ./redis_init.sh

# start supervisord nodaemon
cp ${APP_PATH}/supervisor.conf.d/*.conf /etc/supervisor/conf.d/
/usr/bin/supervisord --nodaemon

