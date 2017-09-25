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

FROM        inugroho/consul-jre

MAINTAINER  isaac.nugroho@gmail.com

ENV         INSTANCE_NAME=instance-1
ENV         CONFIG_DIR=/instance-config
ENV         WORK_ROOT_DIR=/work

USER        root
ADD         supervisor/ /etc/
ADD         run-service /usr/bin/
ADD         config.shlib /usr/bin/

RUN         chmod +x /usr/bin/run-service \
            && mkdir -p ${CONFIG_DIR} ${WORK_ROOT_DIR} \
            && chown nobody:nobody -R ${CONFIG_DIR} ${WORK_ROOT_DIR}

VOLUME      ${CONFIG_DIR}
VOLUME      ${WORK_ROOT_DIR}

EXPOSE      8180 8181 8182 8183 8184
