FROM        alpine:3.6

MAINTAINER  inugroho@gmail.com

ADD         requirements.txt .

RUN       apk add --update \
            python2 \
            py2-pip \
            gcc \
            python2-dev \
            libev \
            libc-dev \
          && pip install -r requirements.txt \
          && apk del py2-pip gcc python2-dev libc-dev libev \
          && rm -rf /var/cache/apk/* /tmp/*

#RUN         apk update
#RUN         apk upgrade
#RUN         apk --no-cache add sudo less vim bash python python-dev gcc libgcc libc-dev py2-pip libev

#RUN         pip install -r requirements.txt \
#            && apk del python-dev gcc libgcc libc-dev py2-pip libev

# Clean APK cache

VOLUME      /data

ADD         dockerdns /
ADD         entrypoint.sh /

ENV         DOMAIN=local.devops

ENTRYPOINT ["/entrypoint.sh"]
