FROM lpicanco/storm

MAINTAINER Luiz Picanço "lpicanco@gmail.com"

RUN /usr/bin/config-supervisord.sh ui

EXPOSE 8080
CMD /usr/bin/start-supervisor.sh

