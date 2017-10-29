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

ADD         supervisor/ /etc/
ADD         build/hashi-ui-linux-amd64 /bin/hashi-ui
ADD         run-hashi-ui.sh /bin/
ADD         99-hashi-consul.json ${CONSUL_CONFIG_DIR}/
RUN         chmod +x bin/hashi-ui /bin/run-hashi-ui.sh

ENV         NOMAD_ADDRESS=""
ENV         HASHI_UI_PARAMS=""
EXPOSE      3000
