FROM ubuntu:xenial-20180123

RUN apt update \
 && apt install -y nginx

ADD entrypoint.sh /

ENTRYPOINT /entrypoint.sh