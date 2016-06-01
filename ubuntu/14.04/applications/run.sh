#!/bin/bash
set -eux

# runtime configuration
cp ${APP_PATH}/supervisor.conf.d/*.conf /etc/supervisor/conf.d/
echo ${PARAM_TEST}

# start supervisord nodaemon
/usr/bin/supervisord --nodaemon

