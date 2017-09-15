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
ADD         run-cassandra.sh /
RUN         chmod +x /run-cassandra.sh

VOLUME      ["${CASSANDRA_DATA}"]

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE      7000 7001 7199 9042 9160


#CMD         ["bash"]
USER        nobody
ENV         HOME=/home/nobody
ENV         USER=nobody
