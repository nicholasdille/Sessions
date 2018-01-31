FROM ubuntu:xenial-20180123

RUN apt-get update \
 && apt-get -y install \
        nginx \
        supervisor

ADD supervisord.conf /etc/supervisor/
ADD nginx.conf /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
