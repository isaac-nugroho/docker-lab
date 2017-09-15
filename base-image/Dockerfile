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

# /dev/urandom is used as random source, which is prefectly safe
# according to http://www.2uo.de/myths-about-urandom/
RUN         ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
            && ALPINE_GLIBC_PACKAGE_VERSION="2.25-r0" \
            && ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
            && ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
            && ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" \
            && apk add --update --no-cache \
              curl \
              wget \
              sudo \
              openssh \
              bash \
              bzip2 \
              unzip \
              python \
              py-pip \
              ca-certificates \
              inotify-tools \
              libpcap \
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
            && rm \
                    "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
                    "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
                    "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
            && pip install supervisor \
            && rm -rf /var/cache/apk/* /tmp/* \
            && sed -i -e "/^nobody/d" /etc/passwd \
            && sed -i -e "/^nobody/d" /etc/shadow \
            && sed -i -e "/^nobody/d" /etc/group \
            && sed -i -e "/^nogroup/d" /etc/group \
            && addgroup -g 65534 nobody \
            && adduser -h /home/nobody -g "" -s /bin/bash -G nobody -D -u65534 nobody \
            && passwd -u nobody \
            && echo 'nobody:N0b0dy!' | chpasswd \
            && echo "nobody ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/nobody" \
            && chmod 0440 "/etc/sudoers.d/nobody" \
            && echo '' >> /etc/ssh/sshd_config \
            && echo 'AllowUsers nobody' >> /etc/ssh/sshd_config \
            && ssh-keygen -h -b 4096 -f /etc/ssh/ssh_host_rsa_key -N "" \
            && mkdir -p /var/log/supervisor \
            && touch /var/log/supervisor/supervisord.log \
            && chown -R nobody:nobody /var/log/supervisor \
            && chmod u=rwx,go=rx,a+s,u+s /var/log/supervisor

ENV         LANG=C.UTF-8

ADD         supervisor/ /etc/
ADD         nobody/ /home/nobody/.ssh/
ADD         authorized_keys /home/nobody/.ssh/

EXPOSE      62435

CMD         ["/usr/bin/sudo", "-E", "/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]
#CMD         ["bash"]
