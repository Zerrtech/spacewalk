FROM fedora:26
MAINTAINER Israel Shirk <israelshirk@gmail.com>

RUN rpm -Uvh http://yum.spacewalkproject.org/2.7/Fedora/26/x86_64/spacewalk-repo-2.7-2.fc26.noarch.rpm && \
	rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
	(cd /etc/yum.repos.d && curl -O https://copr.fedorainfracloud.org/coprs/g/spacewalkproject/java-packages/repo/epel-7/group_spacewalkproject-java-packages-epel-7.repo) && \
	yum -y install spacewalk-postgresql initscripts sqlite supervisor && yum clean all

ADD supervisord.conf /etc/supervisord.conf
ADD supervisord.d /etc/supervisord.d

ENV ADMIN_EMAIL="webmaster@domain.com"
ENV SSL_ORG="MOTIVE MEDIA"
ENV SSL_ORG_UNIT="SHEEPIE SHEEPIE"
ENV SSL_CITY="BOISE"
ENV SSL_STATE="ID"
ENV SSL_COUNTRY="US"
ENV SSL_PASSWORD="spacewalk"
ENV SSL_EMAIL="root@localhost"
ENV SSL_VHOST="N"
ENV DB_BACKEND="postgresql"
ENV DB_NAME="postgres"
ENV DB_USER="postgres"
ENV DB_PASSWORD="postgres"
ENV DB_HOST="postgres"
ENV DB_PORT="5432"
ENV ENABLE_TFTP="N"
ENV HOSTNAME="spacewalk.test.com"
ENV MOUNT_POINT="/var/satellite"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh