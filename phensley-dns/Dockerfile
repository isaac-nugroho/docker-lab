FROM        inugroho/base-image

MAINTAINER  inugroho@gmail.com

USER        root
ADD         requirements.txt .
ADD         dockerdns /home/nobody/
ADD         run-dockerdns.sh /home/nobody/
ADD         supervisor/ /etc/

RUN       apk add --no-cache \
            gcc \
            python2-dev \
            libev \
            libc-dev \
          && pip install -r requirements.txt \
          && apk del gcc python2-dev libc-dev libev \
          && rm -rf /var/cache/apk/* /tmp/* \
          && chown nobody:nobody -R /home/nobody \
          && chmod +x /home/nobody/dockerdns /home/nobody/run-dockerdns.sh /etc/entrypoint.d/*

VOLUME      /data

ENV         DOMAIN=local.devops

USER        nobody
ENV         HOME=/home/nobody
ENV         USER=nobody
