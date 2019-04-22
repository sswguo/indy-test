FROM jboss/base-jdk:8

USER root

RUN yum install -y wget \
    && yum clean all

USER jboss

# COPY auditquery*.tar.gz /tmp/
# wget http://file.apac.redhat.com/~wguo/auditquery-standalone-rest-0.13.0-SNAPSHOT.tar.gz
RUN wget https://github.com/sswguo/openshift-play/blob/master/auditquery/release/auditquery-standalone-rest-0.13.0-SNAPSHOT.tar.gz \
   && tar -xvf auditquery-standalone-rest-0.13.0-SNAPSHOT.tar.gz
#RUN tar -xvf /tmp/auditquery-standalone-rest-0.13.0-SNAPSHOT.tar.gz

COPY conf/*.xml auditquery/etc/auditquery/

EXPOSE 8082

CMD ["/bin/bash", "-c", "auditquery/bin/start.sh"]



