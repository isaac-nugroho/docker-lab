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

FROM        inugroho/base-image

USER        root

ENV         CONSUL_VERSION=1.0.0
ENV         BASE_DATA=/data
ENV         BASE_CONFIG=/config
ENV         CONSUL_DATA_DIR=${BASE_DATA}/consul
ENV         CONSUL_CONFIG_DIR=${BASE_CONFIG}/consul
ENV         CONSUL_BIND_INTERFACE="auto"
ENV         CONSUL_PARAMS=""

RUN         apk add --no-cache --virtual build-dependencies gnupg openssl \
            && gpg --keyserver pgp.mit.edu --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C \
            && mkdir -p /tmp/build \
            && cd /tmp/build \
            && HASHICORP_RELEASES=https://releases.hashicorp.com \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig \
            && gpg --batch --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS \
            && grep consul_${CONSUL_VERSION}_linux_amd64.zip consul_${CONSUL_VERSION}_SHA256SUMS | sha256sum -c \
            && unzip -d /bin consul_${CONSUL_VERSION}_linux_amd64.zip \
            && rm -rf /tmp/* \
            && apk del build-dependencies \
            && mkdir -p ${CONSUL_CONFIG_DIR} ${CONSUL_DATA_DIR} \
            && chown -R nobody:nobody ${CONSUL_CONFIG_DIR} ${CONSUL_DATA_DIR}

ADD         supervisor/ /etc/
ADD         run-consul.sh /bin/
ADD         00-consul-boot.json ${CONSUL_CONFIG_DIR}

EXPOSE      8300 8301 8301/udp 8302 8302/udp 8500 8600 8600/udp

VOLUME      ${BASE_DATA}
VOLUME      ${BASE_CONFIG}
