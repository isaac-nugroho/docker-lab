FROM        alpine:latest

MAINTAINER  inugroho@gmail.com

ADD         requirements.txt .

RUN         apk update
RUN         apk upgrade
RUN         apk --no-cache add sudo less vim bash python python-dev gcc libgcc libc-dev py2-pip libev

RUN         pip install -r requirements.txt \
            && apk del python-dev gcc libgcc libc-dev py2-pip libev

# Clean APK cache
RUN         rm -rf /tmp/* && \
            rm -rf /var/cache/apk/*

VOLUME      /data

ADD         dockerdns /
ADD         entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
