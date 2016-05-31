# 0. 基础镜像 & 维护者信息.
# VERSION: 1.0.0.0
# Author:  yangjun <597092663@qq.com>
# MAINTAINER yangjun <597092663@qq.com>

# 1. 基础镜像.
FROM 10.5.24.46:80/nscloud/ubuntu:2.0

# 2. 镜像BUILD默认参数 & RUN环境变量.
# ARG APP_PATH="/opt/applications"    # !!!No Modification, Must Be Same As Base Image.

ENV TIMEOUT=0
ENV TCP_KEEPALIVE=60
ENV REQUIRE_PAAS=1

# 3. 镜像生成过程操作指令.
ENV APP_PATH=${APP_PATH}
ENV EXPOSE_PORT="22 6379"

# 3.1 将build-depends拷贝到镜像中
# copy build-depends of applications to images
RUN mkdir -p ${APP_PATH}/build-depends
COPY ./applications/build-depends/ ${APP_PATH}/build-depends

# 3.1 安装mysql-server
# apt install packages
RUN apt-get update -y \
    && apt-get install redis-server -y

# 3.9 配置redis-server
# configure mysql-server
RUN mv /etc/redis/redis.conf /etc/redis/redis.conf.bak \
    && cp ${APP_PATH}/build-depends/redis-conf/redis.conf.template /etc/redis/

# 4. 指定容器需要暴露的端口.
# EXPOSE ${EXPOSE_PORT}

# 5. 指定容器需要使用的持久化存储.
# VOLUME ["/var/lib/mysql"]

# 6. 容器启动指令: 如果为LongTime Service，不能起为后台进程.
COPY ./applications/ ${APP_PATH}
RUN chmod a+x ${APP_PATH}/build-depends/redis-conf/redis_init.sh
RUN chmod a+x ${APP_PATH}/run.sh
CMD ["/bin/bash", "-c", "cd ${APP_PATH} && ./run.sh"]

