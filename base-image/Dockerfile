#
# Copyright 2017 zenKoderz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM        alpine:3.6

USER        root

#hashicorp docker-base
ENV         DOCKER_BASE_VERSION=0.0.4

RUN         ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
            && ALPINE_GLIBC_PACKAGE_VERSION="2.26-r0" \
            && ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
            && ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
            && ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
            && HASHICORP_RELEASES="https://releases.hashicorp.com" \
            && apk add --update --no-cache \
                curl \
                wget \
                openssh \
                bash \
                sudo \
                bzip2 \
                unzip \
                python \
                py-pip \
                ca-certificates \
                inotify-tools \
                libpcap \
                coreutils \
            && apk add --no-cache --virtual build-dependencies gnupg openssl \
            && gpg --keyserver pgp.mit.edu --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C \
            && mkdir -p /tmp/build \
            && cd /tmp/build \
            && wget \
                "https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/sgerrand.rsa.pub" \
                -O "/etc/apk/keys/sgerrand.rsa.pub" \
            && wget \
                "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
                "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
                "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
            && apk add --no-cache \
                "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
                "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
                "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
            && rm "/etc/apk/keys/sgerrand.rsa.pub" \
            && /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true \
            && echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh \
            && apk del glibc-i18n \
            && rm "/root/.wget-hsts" \
            && wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_linux_amd64.zip \
            && wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS \
            && wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS.sig \
            && gpg --batch --verify docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS.sig docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS \
            && grep ${DOCKER_BASE_VERSION}_linux_amd64.zip docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS | sha256sum -c \
            && unzip docker-base_${DOCKER_BASE_VERSION}_linux_amd64.zip \
            && cp bin/gosu bin/dumb-init /bin \
            && pip install supervisor \
            && apk del build-dependencies \
            && rm -rf /var/cache/apk/* /tmp/* \
            && sed -i -e "/^nobody/d" /etc/passwd \
            && sed -i -e "/^nobody/d" /etc/shadow \
            && sed -i -e "/^nobody/d" /etc/group \
            && sed -i -e "/^nogroup/d" /etc/group \
            && addgroup -g 65534 nobody \
            && adduser -h /home/nobody -g "" -s /bin/bash -G nobody -D -u65534 nobody \
            && passwd -u nobody \
            && echo 'nobody:Horse-staple-bridge1' | chpasswd \
            && echo "nobody ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/nobody" \
            && chmod 0440 "/etc/sudoers.d/nobody" \
            && echo '' >> /etc/ssh/sshd_config \
            && echo 'AllowUsers nobody' >> /etc/ssh/sshd_config \
            && ssh-keygen -h -b 4096 -f /etc/ssh/ssh_host_rsa_key -N "" \
            && mkdir -p /home/nobody/.ssh \
            && chown -R nobody:nobody /home/nobody \
            && chmod 700 -R /home/nobody/.ssh

ENV         LANG=C.UTF-8

ADD         supervisor/ /etc/

COPY        nobody/* /home/nobody/.ssh/

RUN         chmod 600 /home/nobody/.ssh/id_rsa /home/nobody/.ssh/authorized_keys \
            && chown nobody:nobody /home/nobody/.ssh/*

EXPOSE      62435

CMD         ["sudo", "-E", "/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]
