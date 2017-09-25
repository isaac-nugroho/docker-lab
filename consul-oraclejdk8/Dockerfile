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

USER        root

ENV         JAVA_VERSION=8 \
            JAVA_UPDATE=144 \
            JAVA_BUILD=01 \
            JAVA_HOME="/usr/lib/jvm/default-jvm"

RUN         cd "/tmp" \
            && JAVA_PATH="090f390dda5b47b9b721c7dfaa008135" \
            && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
                "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
            && tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" \
            && mkdir -p "/usr/lib/jvm" \
            && mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" \
            && ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" \
            && ln -s "$JAVA_HOME/bin/"* "/usr/bin/" \
            && rm -rf "$JAVA_HOME/"*src.zip \
            && rm -rf "$JAVA_HOME/lib/missioncontrol" \
                "$JAVA_HOME/lib/visualvm" \
            && wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
                "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" \
            && unzip -jo -d "${JAVA_HOME}/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip" \
            && rm "${JAVA_HOME}/jre/lib/security/README.txt" \
            && rm -rf /tmp/*

ADD         java-home /etc/profile.d/
