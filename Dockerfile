FROM lpicanco/java:8

MAINTAINER Luiz Picanço "lpicanco@gmail.com"

RUN apt-get update; apt-get install -y unzip wget supervisor docker.io openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN wget -q -O - http://mirrors.sonic.net/apache/storm/apache-storm-0.10.0/apache-storm-0.10.0.tar.gz | tar -xzf - -C /opt

ENV STORM_HOME /opt/apache-storm-0.10.0
RUN groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm

RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm

ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml
ADD config-supervisord.sh /usr/bin/config-supervisord.sh
ADD start-supervisor.sh /usr/bin/start-supervisor.sh

RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf