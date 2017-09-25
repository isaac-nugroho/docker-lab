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

FROM        inugroho/base-consul

MAINTAINER  isaac.nugroho@gmail.com

USER        root

ENV         NOMAD_VERSION=0.6.3

ENV         NOMAD_DATA_DIR=${BASE_DATA}/nomad \
            NOMAD_CONFIG_DIR=${BASE_CONFIG}/nomad \
            NOMAD_BIND_INTERFACE="auto" \
            NOMAD_PARAMS=""

RUN         apk add --no-cache --virtual build-dependencies gnupg openssl \
            && gpg --keyserver pgp.mit.edu --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C \
            && mkdir -p /tmp/build \
            && cd /tmp/build \
            && HASHICORP_RELEASES=https://releases.hashicorp.com \
            && wget ${HASHICORP_RELEASES}/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip \
            && wget ${HASHICORP_RELEASES}/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_SHA256SUMS \
            && wget ${HASHICORP_RELEASES}/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_SHA256SUMS.sig \
            && gpg --batch --verify nomad_${NOMAD_VERSION}_SHA256SUMS.sig nomad_${NOMAD_VERSION}_SHA256SUMS \
            && grep nomad_${NOMAD_VERSION}_linux_amd64.zip nomad_${NOMAD_VERSION}_SHA256SUMS | sha256sum -c \
            && unzip -d /bin nomad_${NOMAD_VERSION}_linux_amd64.zip \
            && rm -rf /tmp/* \
            && apk del build-dependencies \
            && mkdir -p ${NOMAD_CONFIG_DIR} ${NOMAD_DATA_DIR}

ADD         supervisor/ /etc/
ADD         run-nomad.sh /bin/
RUN         chmod +x /bin/run-nomad.sh

EXPOSE      4646 4647 4648
