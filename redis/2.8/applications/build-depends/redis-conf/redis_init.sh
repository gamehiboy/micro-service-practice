#!/bin/bash
set -eux

# redis-server configuration
set +eu && source ~/.bashrc && set -eu && env
if [ "${REQUIRE_PAAS}" = "1" ] && [ "${REDIS_PAASWORD:-NOTDEF}" = "NOTDEF" ]; then
    echo "redis password is not set yet, start to generate new"
    REDIS_PAASWORD=`date +%s | sha256sum | base64 | head -c 32 ; echo`
    sed -i "1a export REDIS_PAASWORD=${REDIS_PAASWORD}\n" ~/.bashrc
    set +eu && source ~/.bashrc && set -eu
else
    echo "redis password is not required or just set already, skip to use the exist"
fi 
python ${APP_PATH}/build-utils/configueUpdate/templateInvoke.py /etc/redis/redis.conf.template /etc/redis/redis.conf \
    && chmod 644 /etc/redis/redis.conf
