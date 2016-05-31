#!/bin/bash
set -x

SVN_USER='cloud_builder'
SVN_PASS='Nsf0cus!@#'
SVN_REPO_URL=${SVN_REPO_URL}
SVN_REPO_VERSION=${SVN_REPO_VERSION:-'HEAD'}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}

#执行SQL相关命令
CONNECTED=$(netstat -alnt | grep -c ":3306 ")
while [ ${CONNECTED} -eq 0 ]; do
    echo "MYSQL NOT CONNECTED YET";
    sleep 20;
    CONNECTED=$(netstat -alnt | grep -c ":3306 ")
done

SVN_FILE_NAME=`basename ${SVN_REPO_URL}`
SVN_DIR_NAME=${SVN_REPO_URL%${SVN_FILE_NAME}}
TMP_DIR_NAME=`mktemp -d`
#####################checkout sql file##############################
echo p | svn checkout ${SVN_DIR_NAME} ${TMP_DIR_NAME} --username ${SVN_USER} --password ${SVN_PASS} -r ${SVN_REPO_VERSION} --no-auth-cache
echo 'checkout sql file completedly'

#####################run sql##############################
mysql -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" < ${TMP_DIR_NAME}/${SVN_FILE_NAME}
echo 'run sql completedly'

