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

FROM        inugroho/builder-oraclejdk8

MAINTAINER  isaac.nugroho@gmail.com

ARG         user=jenkins
ARG         group=jenkins
ARG         uid=1000
ARG         gid=1000
ARG         http_port=8080
ARG         agent_port=50000

ENV         JENKINS_VERSION=2.86
ENV         JENKINS_UC https://updates.jenkins.io
ENV         JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
ENV         JENKINS_HOME /var/jenkins_home
ENV         JENKINS_SLAVE_AGENT_PORT ${agent_port}
ENV         JENKINS_UC https://updates.jenkins.io
ENV         JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
ENV         COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log
ENV         JENKINS_PARAMS=""

VOLUME      /var/jenkins_home
USER        root
RUN         apk --no-cache add ttf-dejavu \
            && mkdir -p /usr/share/jenkins/ref/init.groovy.d/ \
            && JENKINS_WAR_SHA256=207aac187882bcddf665cdee78daa2fd8642f94c02d731b9ea18fdc985640ea5 \
            && JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war \
            && curl -fsSL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war \
            && echo "${JENKINS_WAR_SHA256} /usr/share/jenkins/jenkins.war" | sha256sum -c - \
            && addgroup -g ${gid} ${group} \
            && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}

COPY        jenkins-support /usr/local/bin/jenkins-support
COPY        run-jenkins.sh /usr/local/bin/run-jenkins.sh
COPY        init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
COPY        plugins.sh /usr/local/bin/plugins.sh
COPY        install-plugins.sh /usr/local/bin/install-plugins.sh
COPY        supervisor/ /etc/

EXPOSE      ${agent_port} ${http_port}
