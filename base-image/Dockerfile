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

FROM        nimmis/java-centos:openjdk-7-jdk

MAINTAINER  isaac.nugroho@gmail.com

RUN         rpm --rebuilddb \
          	&& rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 \
          	&& rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
          	&& rpm --import https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY

RUN         yum update -y \
            && yum install --setopt=tsflags=nodocs -y \
              centos-release-scl \
              centos-release-scl-rh \
              https://centos7.iuscommunity.org/ius-release.rpm \
            && yum install --setopt=tsflags=nodocs -y \
              less \
              sudo \
              rsync \
              bash \
              epel-release \
              openssh \
              openssh-server \
              openssh-clients \
              openssl \
              python-setuptools \
              inotify-tools \
              curl \
              wget \
              dnsutils \
              net-tools \
              xz \
              vim-minimal \
              libc-bin && \
            yum clean all \
            && rm -rf /etc/ld.so.cache \
          	&& rm -rf /sbin/sln \
          	&& rm -rf /usr/{{lib,share}/locale,share/{man,doc,info,cracklib,i18n},{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive} \
          	&& rm -rf /{root,tmp,var/cache/{ldconfig,yum}}/*
#          	&& > /etc/sysconfig/i18n

RUN         easy_install pip && pip install supervisor supervisor-stdout
ADD         supervisor/ /etc/
ADD         supervisord /etc/rc.d/init.d/

RUN         mkdir -p /var/log/supervisor && touch /var/log/supervisor/supervisord.log

RUN         ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
            && echo "NETWORKING=yes" > /etc/sysconfig/network

RUN         sed -i \
              -e 's~^PasswordAuthentication yes~PasswordAuthentication no~g' \
              -e 's~^#PermitRootLogin yes~PermitRootLogin no~g' \
              -e 's~^#UseDNS yes~UseDNS no~g' \
              -e 's~^\(.*\)/usr/libexec/openssh/sftp-server$~\1internal-sftp~g' \
              /etc/ssh/sshd_config \
            && echo '' >> /etc/ssh/sshd_config \
            && echo 'AllowUsers nobody' >> /etc/ssh/sshd_config \
            && ssh-keygen -h -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""

RUN         sed -i \
            	-e 's~^# %wheel\tALL=(ALL)\tNOPASSWD: ALL~%wheel\tALL=(ALL)\tNOPASSWD: ALL~g' \
            	-e 's~\(.*\) requiretty$~#\1requiretty~' \
            	/etc/sudoers

#RUN         systemctl enable ntp.service
RUN         usermod -d /home/nobody -s /bin/bash -G wheel nobody \
            && usermod -U nobody \
            && cp -r /etc/skel /home/nobody \
            && mkdir -p /home/nobody/.ssh

ADD         nobody/ /home/nobody/.ssh/
ADD         authorized_keys /home/nobody/.ssh/

RUN         chown -R nobody:nobody /home/nobody \
            && chmod 700 /home/nobody/.ssh \
            && chmod 600 /home/nobody/.ssh/id_rsa /home/nobody/.ssh/authorized_keys

#USER        nobody
#ENV         HOME=/home/nobody
#WORKDIR     /home/nobody

EXPOSE      22

CMD         ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]
#CMD         ["bash"]
