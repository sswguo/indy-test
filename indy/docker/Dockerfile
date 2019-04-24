FROM jboss/base-jdk:8

USER root

EXPOSE 8080

WORKDIR /opt

ARG gc_log=/opt/indy/var/log/indy/indy-gc.log

COPY indy-launcher-1.8.0-SNAPSHOT-complete.tar.gz /tmp/indy.tar.gz

RUN tar -zxf /tmp/indy.tar.gz -C /opt && rm /tmp/indy.tar.gz

COPY  infinispan*.conf indy/etc/indy/conf.d/

RUN chgrp -R 0 /opt/indy && \
    chmod -R g=u /opt/indy

CMD ["/bin/bash", "-c", "indy/bin/indy.sh"]

