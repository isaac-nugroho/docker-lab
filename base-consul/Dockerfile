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

ENV         CONSUL_VERSION=0.9.3

# This is the release of https://github.com/hashicorp/docker-base to pull in order
# to provide HashiCorp-built versions of basic utilities like dumb-init and gosu.
ENV         DOCKER_BASE_VERSION=0.0.4

# This is the location of the releases.
ENV         HASHICORP_RELEASES=https://releases.hashicorp.com

RUN         apk add --no-cache --virtual build-dependencies gnupg openssl \
            && gpg --keyserver pgp.mit.edu --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C \
            && mkdir -p /tmp/build \
            && cd /tmp/build \
            && wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_linux_amd64.zip \
            && wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS \
            && wget ${HASHICORP_RELEASES}/docker-base/${DOCKER_BASE_VERSION}/docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS.sig \
            && gpg --batch --verify docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS.sig docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS \
            && grep ${DOCKER_BASE_VERSION}_linux_amd64.zip docker-base_${DOCKER_BASE_VERSION}_SHA256SUMS | sha256sum -c \
            && unzip docker-base_${DOCKER_BASE_VERSION}_linux_amd64.zip \
            && cp bin/gosu bin/dumb-init /bin \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig \
            && gpg --batch --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS \
            && grep consul_${CONSUL_VERSION}_linux_amd64.zip consul_${CONSUL_VERSION}_SHA256SUMS | sha256sum -c \
            && unzip -d /bin consul_${CONSUL_VERSION}_linux_amd64.zip \
            && cd /tmp \
            && rm -rf /tmp/build \
            && apk del build-dependencies 

EXPOSE      8300 8301 8301/udp 8302 8302/udp 8500 8600 8600/udp

ADD         supervisor/ /etc/
ADD         run-consul.sh /

RUN         chmod +x /run-consul.sh

ENV         CONSUL_DATA_DIR=/consul/data
ENV         CONSUL_CONFIG_DIR=/consul/config

ADD         00-consul-boot.json ${CONSUL_CONFIG_DIR}/

USER        nobody
ENV         HOME=/home/nobody
ENV         USER=nobody
