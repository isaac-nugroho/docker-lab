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

ENV         MARIADB_ROOT_PASSWORD=CHANGE_THIS_DEFAULT_PASSWORD

ENV         MARIADB_DATA=/var/lib/mariadb

RUN         apk add --no-cache \
              mariadb \
              mariadb-client

ADD         supervisor/ /etc/
ADD         run-mariadb.sh /
RUN         chmod +x /run-mariadb.sh

USER        nobody
ENV         HOME=/home/nobody
ENV         USER=nobody
