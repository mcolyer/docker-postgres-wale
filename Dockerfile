FROM postgres:9.4

MAINTAINER Luke Smith

RUN apt-get update && apt-get install -y python-pip python-dev lzop pv daemontools python-keystoneclient
RUN pip install setuptools
RUN pip install wal-e

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD fix-acl.sh /docker-entrypoint-initdb.d/
ADD setup-wale.sh /docker-entrypoint-initdb.d/
