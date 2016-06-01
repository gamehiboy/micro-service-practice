#!/bin/bash
set -eux
env

datafile="/var/lib/mysql"
files=`ls ${datafile}`
if [ -z "${files}" ]; then 
    echo "${datafile} is empty, database is uninitialized"
    mysql_install_db --defaults-file=/etc/mysql/my.cnf \
        && service mysql start \
        && mysql -e "grant all privileges on *.* to 'root'@'%' identified by '${MYSQL_ROOT_PASSWORD}';" \
        && mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by '${MYSQL_ROOT_PASSWORD}';" \
        && mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE ${MYSQL_DATABASE};" \
        && mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "grant all privileges on *.* to '${MYSQL_USER}'@'%' identified by '${MYSQL_PASSWORD}';" \
        && mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "grant all privileges on *.* to '${MYSQL_USER}'@'localhost' identified by '${MYSQL_PASSWORD}';" 
    if [ "${SVN_REPO_URL:-NOTDEF}" != "NOTDEF" ]; then
        echo "need to execute sql scripts"
        cd ${APP_PATH}/deploy/scripts/ && ./execute_sql.sh
    else
        echo "no need to execute sql scripts, skip"
    fi
    killall mysqld
    echo 'Database initialized'
else
    echo "${datafile} is not empty, database is initialized, skip"
fi
