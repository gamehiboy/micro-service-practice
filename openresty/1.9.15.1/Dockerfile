# 0. 基础镜像 & 维护者信息.
# VERSION: 1.0.0.0
# Author:  yangjun <597092663@qq.com>
# MAINTAINER yangjun <597092663@qq.com>

# 1. 基础镜像.
FROM 10.5.24.46:80/nscloud/ubuntu:2.0

# 2. 镜像BUILD默认参数 & RUN环境变量.
# ARG APP_PATH="/opt/applications"    # !!!No Modification, Must Be Same As Base Image.

# 3. 镜像生成过程操作指令.
ENV APP_PATH=${APP_PATH}
ENV EXPOSE_PORT="22 80 443"

# 3.1 将build-depends拷贝到镜像中
# copy build-depends of applications to images
RUN mkdir -p ${APP_PATH}/build-depends
COPY ./applications/build-depends/ ${APP_PATH}/build-depends

# 3.1 编译安装OpenResty
# apt install packages
RUN apt-get update -y \
    && apt-get install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential -y
RUN cd ${APP_PATH} && cp ./build-depends/openresty/openresty-1.9.15.1.tar.gz . && tar -xzvf openresty-1.9.15.1.tar.gz && rm -rf *.tar.gz \
    && pushd ./openresty-1.9.15.1/bundle/LuaJIT-2.1-20160517/ && make clean && make && make install && popd \
    && cp ./build-depends/openresty/nginx_upstream_check_module-0.3.0.tar.gz ./openresty-1.9.15.1/bundle \
    && cp ./build-depends/openresty/ngx_cache_purge-2.3.tar.gz ./openresty-1.9.15.1/bundle \
    && pushd ./openresty-1.9.15.1/bundle && for tar in *.tar.gz; do tar -xzvf ${tar}; done && rm -rf *.tar.gz && popd \
    && pushd ./openresty-1.9.15.1 && ./configure --prefix=${APP_PATH}/openresty --with-http_realip_module --with-pcre --with-luajit --with-http_iconv_module --add-module=./bundle/ngx_cache_purge-2.3/ --add-module=./bundle/nginx_upstream_check_module-0.3.0/ -j2 \
    && make && make install && popd

# 4. 指定容器需要暴露的端口.
# EXPOSE ${EXPOSE_PORT}

# 5. 指定容器需要使用的持久化存储.
# VOLUME ["/var/lib/mysql"]

# 6. 容器启动指令: 如果为LongTime Service，不能起为后台进程.
COPY ./applications/ ${APP_PATH}
RUN chmod a+x ${APP_PATH}/run.sh
CMD ["/bin/bash", "-c", "cd ${APP_PATH} && ./run.sh"]

