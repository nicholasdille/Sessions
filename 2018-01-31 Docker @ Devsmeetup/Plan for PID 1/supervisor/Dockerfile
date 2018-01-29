FROM ubuntu:xenial-20180123
RUN apt update \
 && apt install -y \
        nginx \
        supervisor
ADD nginx.conf /etc/supervisor/conf.d/
ENTRYPOINT supervisord