#!/bin/bash
set -x

# adjust kernel parameters
mv /etc/sysctl.conf /etc/sysctl.conf.back
cp -rf ${APP_PATH}/build-depends/kernel/sysctl.conf /etc/
sysctl -p
