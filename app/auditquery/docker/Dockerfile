FROM jboss/base-jdk:8

USER root

WORKDIR /opt

COPY auditquery-standalone-rest-0.13.0-SNAPSHOT.tar.gz /tmp/auditquery.tar.gz

RUN tar -xvf /tmp/auditquery.tar.gz -C /opt && rm /tmp/auditquery.tar.gz

COPY conf/*.xml auditquery/conf/

EXPOSE 8082

RUN chgrp -R 0 /opt/auditquery && \
chmod -R g=u /opt/auditquery

CMD ["/bin/bash", "-c", "auditquery/bin/start.sh"]



