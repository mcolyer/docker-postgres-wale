FROM postgres:11.5

MAINTAINER Matt Colyer

RUN apt-get update && \
  apt-get install -y python3-pip python3-dev lzop pv daemontools python3-keystoneclient && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip3 install setuptools
RUN pip3 install wal-e boto

RUN mkdir -p /etc/wal-e.d/ && chown postgres.postgres /etc/wal-e.d/
ADD fix-acl.sh /docker-entrypoint-initdb.d/
ADD setup-wale.sh /docker-entrypoint-initdb.d/
