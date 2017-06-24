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

USER        root
ADD         supervisor/ /etc/
ADD         run-service /usr/bin/
ADD         resolve-dns /usr/bin/
ADD         config.shlib /usr/bin/

RUN         chmod +x /usr/bin/resolve-dns /usr/bin/run-service

RUN         mkdir -p /data/dns \
            && mkdir -p /data/repository \
            && mkdir -p /home/nobody/.m2 \
            && chown nobody:nobody /home/nobody/.m2 \
            && ln -s /data/repository /home/nobody/.m2/repository

USER        nobody
ENV         HOME=/home/nobody
ENV         USER=nobody

ENV         INSTANCE_NAME=instance-1

VOLUME      /data

EXPOSE      8180 8181 8182 8183 8184
