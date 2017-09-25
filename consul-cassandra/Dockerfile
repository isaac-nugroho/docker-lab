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

FROM        inugroho/consul-oraclejdk8

USER        root

ENV         CASSANDRA_VERSION=3.11.0

ENV         CASSANDRA_HOME=/opt/cassandra \
            CASSANDRA_LOGS=/var/log/cassandra \
            CASSANDRA_DATA=/var/lib/cassandra \
            CASSANDRA_CONFIG=/etc/cassandra

ENV         CASSANDRA_CLUSTER_NAME='Test Cluster'

ENV         JAVA_HOME=/usr/lib/jvm/default-jvm
ENV         PATH=$PATH:${JAVA_HOME}/bin:${CASSANDRA_HOME}/bin

RUN         set -x \
            && apk --no-cache add \
              jemalloc \
            && wget http://www-us.apache.org/dist/cassandra/${CASSANDRA_VERSION}/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz -P /tmp \
            && tar -xvzf /tmp/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz -C /tmp/ \
            && mkdir -p /opt \
            && mv /tmp/apache-cassandra-${CASSANDRA_VERSION} ${CASSANDRA_HOME} \
            && rm -rf \
              ${CASSANDRA_HOME}/bin/*.bat \
              ${CASSANDRA_HOME}/doc \
              ${CASSANDRA_HOME}/javadoc \
              /tmp/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz \
              /var/cache/apk/* \
            && addgroup cassandra \
            && adduser -h $CASSANDRA_HOME -g "" -s /bin/bash -G cassandra -D cassandra \
            && mkdir -p "$CASSANDRA_DATA" "$CASSANDRA_LOGS" \
            && chown -R cassandra:cassandra "$CASSANDRA_DATA" "$CASSANDRA_LOGS" \
            && mv $CASSANDRA_HOME/conf "$CASSANDRA_CONFIG" \
            && ln -s $CASSANDRA_DATA $CASSANDRA_HOME/data \
            && ln -s $CASSANDRA_LOGS $CASSANDRA_HOME/logs \
            && ln -s $CASSANDRA_CONFIG $CASSANDRA_HOME/conf

ADD         supervisor/ /etc/
ADD         99-cassandra-consul.json ${CONSUL_CONFIG_DIR}/
ADD         run-cassandra.sh /
ADD         node-repair-after-full-boot.sh /
ADD         replace_node_patch.sh /
ADD         heap-patch.sh /
RUN         chmod +x /run-cassandra.sh /node-repair-after-full-boot.sh \
            && cat replace_node_patch.sh >> $CASSANDRA_CONFIG/cassandra-env.sh \
            && rm replace_node_patch.sh \
            && mkdir -p /root/.cassandra /home/cassandra \
            && echo "[connection]\nclient_timeout=40" > /root/.cassandra/cqlshrc \
            && awk -v s="$(cat heap-patch.sh)" -e "/\s*#MAX_HEAP_SIZE/ { print s} { print }" /etc/cassandra/cassandra-env.sh > /tmp/cassandra-env.sh \
            && rm /etc/cassandra/cassandra-env.sh \
            && mv /tmp/cassandra-env.sh /etc/cassandra/cassandra-env.sh

ENV         CASSANDRA_SEEDS=auto \
            CASSANDRA_BROADCAST_ADDRESS=auto \
            CASSANDRA_LISTEN_ADDRESS=auto \
            CASSANDRA_PARAMS="" \
            CASSANDRA_MAX_HEAP_SIZE="default" \
            CASSANDRA_HEAP_NEWSIZE="default"

VOLUME      ["${CASSANDRA_DATA}"]

EXPOSE      7000 7001 7199 9042 9160
