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

FROM        inugroho/base-image-jre

MAINTAINER  isaac.nugroho@gmail.com

USER        root

ENV         CONSUL_VERSION=0.9.2
ENV         NOMAD_VERSION=0.6.2

# This is the release of https://github.com/hashicorp/docker-base to pull in order
# to provide HashiCorp-built versions of basic utilities like dumb-init and gosu.
ENV         DOCKER_BASE_VERSION=0.0.4

# This is the location of the releases.
ENV         HASHICORP_RELEASES=https://releases.hashicorp.com

RUN         apk add --no-cache ca-certificates gnupg libcap openssl libc6-compat \
            && gpg --keyserver pgp.mit.edu --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C \
            && mkdir -p /tmp/build \
            && cd /tmp/build \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS \
            && wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig \
            && gpg --batch --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS \
            && grep consul_${CONSUL_VERSION}_linux_amd64.zip consul_${CONSUL_VERSION}_SHA256SUMS | sha256sum -c \
            && unzip -d /bin consul_${CONSUL_VERSION}_linux_amd64.zip \
            && wget ${HASHICORP_RELEASES}/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip \
            && wget ${HASHICORP_RELEASES}/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_SHA256SUMS \
            && wget ${HASHICORP_RELEASES}/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_SHA256SUMS.sig \
            && gpg --batch --verify nomad_${NOMAD_VERSION}_SHA256SUMS.sig nomad_${NOMAD_VERSION}_SHA256SUMS \
            && grep nomad_${NOMAD_VERSION}_linux_amd64.zip nomad_${NOMAD_VERSION}_SHA256SUMS | sha256sum -c \
            && unzip -d /bin nomad_${NOMAD_VERSION}_linux_amd64.zip \
            && cd /tmp \
            && rm -rf /tmp/build \
            && apk del gnupg openssl \
            && rm -rf /root/.gnupg \
            && mkdir -p /consul/data \
            && mkdir -p /consul/config \
            && mkdir -p /nomad/data \
            && mkdir -p /nomad/config \
            && chown -R nobody:nobody /consul


EXPOSE      8300 8301 8301/udp 8302 8302/udp 8500 8600 8600/udp 4646 4647 4648

ADD         supervisor/ /etc/

USER        nobody
ENV         HOME=/home/nobody
ENV         USER=nobody
