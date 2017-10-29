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

ENV         JAVA_VERSION=8 \
            JAVA_UPDATE=152 \
            JAVA_BUILD=16 \
            JAVA_HOME="/usr/lib/jvm/default-jvm"
RUN         cd "/tmp" \
            && JAVA_PATH="aa0333dd3019491ca4f6ddbe78cdb6d0" \
            && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
                "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
            && mkdir -p "/usr/lib/jvm" \
            && tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
            && mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" \
            && ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" \
            && ln -s "$JAVA_HOME/bin/"* "/usr/bin/" \
            && rm -rf /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/*src.zip \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/lib/missioncontrol \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/lib/visualvm \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/lib/*javafx* \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/plugin.jar \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/ext/jfxrt.jar \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/bin/javaws \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/javaws.jar \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/desktop \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/plugin \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/deploy* \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/*javafx* \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/*jfx* \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/amd64/libdecora_sse.so \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/amd64/libprism_*.so \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/amd64/libfxplugins.so \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/amd64/libglass.so \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/amd64/libgstreamer-lite.so \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/amd64/libjavafx*.so \
                /usr/lib/jvm/java-${JAVA_VERSION}-oracle/jdk/jre/lib/amd64/libjfx*.so \
            && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
                "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" \
            && unzip -jo -d "${JAVA_HOME}/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip" \
            && rm "${JAVA_HOME}/jre/lib/security/README.txt" \
            && rm -rf /tmp/* \

ADD         java-home /etc/profile.d/
USER        nobody
ENV         HOME=/home/nobody
ENV         USER=nobody
