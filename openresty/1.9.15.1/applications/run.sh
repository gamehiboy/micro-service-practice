#!/bin/bash
set -eux
env

# start supervisord nodaemon
python ${APP_PATH}/build-utils/configueUpdate/templateInvoke.py ${APP_PATH}/supervisor.conf.d/nginx.conf.template ${APP_PATH}/supervisor.conf.d/nginx.conf
cp ${APP_PATH}/supervisor.conf.d/*.conf /etc/supervisor/conf.d/
/usr/bin/supervisord --nodaemon

