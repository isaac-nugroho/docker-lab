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

USER        root

ENV         ACTIVEMQ_VERSION 5.14.5
ENV         ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION
ENV         ACTIVEMQ_TCP=61616 \
            ACTIVEMQ_AMQP=5672 \
            ACTIVEMQ_STOMP=61613 \
            ACTIVEMQ_MQTT=1883 \
            ACTIVEMQ_WS=61614 \
            ACTIVEMQ_UI=8161

ENV         ACTIVEMQ_HOME /opt/activemq

RUN         set -x \
            && mkdir -p /opt \
            && curl -s -S https://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/$ACTIVEMQ-bin.tar.gz | tar xvz -C /opt \
            && rm -rf /opt/$ACTIVEMQ/examples /opt/$ACTIVEMQ/webapps-demo \
            && mv /opt/$ACTIVEMQ $ACTIVEMQ_HOME \
            && addgroup activemq \
            && adduser -h $ACTIVEMQ_HOME -g "" -s /bin/bash -G activemq -D activemq \
            && chown -R activemq:activemq $ACTIVEMQ_HOME

EXPOSE      $ACTIVEMQ_TCP $ACTIVEMQ_AMQP $ACTIVEMQ_STOMP $ACTIVEMQ_MQTT $ACTIVEMQ_WS $ACTIVEMQ_UI

ADD         supervisor/ /etc/
ADD         99-activemq-consul.json ${CONSUL_CONFIG_DIR}/

VOLUME      /opt/activemq/data
