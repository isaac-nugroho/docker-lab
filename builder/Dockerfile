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

MAINTAINER  isaac.nugroho@gmail.com

RUN         yum install --setopt=tsflags=nodocs -y \
              git \
              nodejs \
              npm \
              http-parser.x86_64 \
            && yum clean all

RUN         wget http://mirror.cc.columbia.edu/pub/software/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz \
            && sudo tar xzf apache-maven-3.5.0-bin.tar.gz -C /usr/local \
            && cd /usr/local \
            && ln -s apache-maven-3.5.0 maven \
            && echo 'export PATH=/usr/local/maven/bin:${PATH}' > /etc/profile.d/maven.sh

RUN         wget https://services.gradle.org/distributions/gradle-3.5-bin.zip \
            && mkdir /opt/gradle \
            && unzip -d /opt/gradle gradle-3.5-bin.zip \
            && cd /usr/bin \
            && ln -s /opt/gradle/bin/gradle gradle

ADD         supervisor/ /etc/

USER        nobody
ENV         HOME=/home/nobody
ENV         USER=nobody

VOLUME      /data
