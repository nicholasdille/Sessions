FROM ubuntu:xenial-20180123

#RUN apt update \
# && apt -y install \
#        nginx=1.10.3*

ENV NGINX_VERSION=1.10.3
RUN apt update \
 && apt -y install \
        nginx=${NGINX_VERSION}*