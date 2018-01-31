FROM ubuntu:xenial-20180123

#RUN apt-get update \
# && apt-get -y install \
#        nginx=1.10.3*

ENV NGINX_VERSION=1.10.3
RUN apt-get update \
 && apt-get -y install \
        nginx=${NGINX_VERSION}*

CMD ["nginx", "-g", "daemon off;"]
