#!/bin/bash
set -eux
env

# config OpenResty
cp -rf ${APP_PATH}/nginx-conf.d ${APP_PATH}/openresty/nginx/conf/
mv ${APP_PATH}/openresty/nginx/conf/nginx.conf ${APP_PATH}/openresty/nginx/conf/nginx.conf.bak
cp -rf ${APP_PATH}/nginx-conf.d/nginx.conf ${APP_PATH}/openresty/nginx/conf/

# start supervisord nodaemon
python ${APP_PATH}/build-utils/configueUpdate/templateInvoke.py ${APP_PATH}/supervisor.conf.d/nginx.conf.template ${APP_PATH}/supervisor.conf.d/nginx.conf
cp ${APP_PATH}/supervisor.conf.d/*.conf /etc/supervisor/conf.d/
/usr/bin/supervisord --nodaemon

