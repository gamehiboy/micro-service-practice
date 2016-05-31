#!/bin/bash
set -x

API_domain=${API_domain}
API_Proxy_IP=${API_Proxy_IP}

# add hosts update tool
cp -rf ${APP_PATH}/build-depends/mungehosts /usr/local/bin/ && chmod 755 /usr/local/bin/mungehosts
# add hosts
mungehosts -a "10.7.101.70  hao.lab.intra.nsfocus.com"
API_Proxy_IP_List=(`echo ${API_Proxy_IP} | tr ";" "\n"`)
if [ ${#API_Proxy_IP_List[@]} -ne 1 ]; then
    echo "==========API_Proxy_IP Has More Than One Item, Do Nothing...=========="
else
    echo "==========API_Proxy_IP Has One Item, Update The /etc/hosts...=========="
    mungehosts -a "${API_Proxy_IP}  ${API_domain}"
fi

