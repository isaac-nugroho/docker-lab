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

ADD         login.cnf /etc/

ENV         MYSQL_ROOT_PASSWORD=CHANGE_THIS_DEFAULT_PASSWORD

ENV         MYSQL_DATA=/var/lib/mysql

RUN         apk add --no-cache \
                gcc \
                libaio \
                --virtual build-dependencies \
                rpm
RUN         PACKAGE_URL=https://repo.mysql.com/yum/mysql-5.7-community/docker/x86_64/mysql-community-server-minimal-5.7.19-1.el7.x86_64.rpm \
            && PACKAGE_URL_SHELL=https://repo.mysql.com/yum/mysql-tools-community/el/7/x86_64/mysql-shell-1.0.10-1.el7.x86_64.rpm \
            && rpmkeys --import https://repo.mysql.com/RPM-GPG-KEY-mysql \
            && rpm -Uvh $PACKAGE_URL $PACKAGE_URL_SHELL \
            && mkdir /docker-entrypoint-initdb.d \
            && apk del build-dependencies

ADD         supervisor/ /etc/
ADD         run-mysql.sh /bin
RUN         chmod +x /run-mysql.sh
