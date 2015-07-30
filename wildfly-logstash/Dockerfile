FROM jboss/wildfly:9.0.1.Final

RUN curl -L https://repository.jboss.org/nexus/service/local/repositories/releases/content/org/jboss/logmanager/jboss-logmanager-ext/1.0.0.Alpha3/jboss-logmanager-ext-1.0.0.Alpha3.jar -o /opt/jboss/wildfly/jboss-logmanager-ext-1.0.0.Alpha3.jar

ADD logstash-module.sh /opt/jboss/wildfly/logstash-module.sh

CMD ["/opt/jboss/wildfly/logstash-module.sh"]
