FROM jboss/wildfly
MAINTAINER Arun Gupta <arungupta@redhat.com>

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0"]

RUN curl -L https://github.com/javaee-samples/javaee7-hol/raw/master/solution/movieplex7-1.0-SNAPSHOT.war -o /opt/jboss/wildfly/standalone/deployments/movieplex7-1.0-SNAPSHOT.war

