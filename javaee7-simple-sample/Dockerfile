FROM jboss/wildfly
MAINTAINER Arun Gupta <arungupta@redhat.com>

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0"]

RUN curl -L https://github.com/javaee-samples/javaee7-simple-sample/releases/download/v1.10/javaee7-simple-sample-1.10.war -o /opt/jboss/wildfly/standalone/deployments/javaee7-simple-sample.war

