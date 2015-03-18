#FROM arungupta/wildfly-centos
FROM jboss/wildfly
MAINTAINER Arun Gupta <arungupta@redhat.com>

COPY jrebel.jar $JBOSS_HOME/jrebel.jar
COPY libjrebel64.so $JBOSS_HOME/libjrebel64.so

RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Drebel.remoting_plugin=true -agentpath:\$JBOSS_HOME/libjrebel64.so\"" >> $JBOSS_HOME/bin/standalone.conf

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0"]

#RUN curl -L https://github.com/javaee-samples/javaee7-hol/raw/master/solution/movieplex7-1.0-SNAPSHOT.war -o /opt/jboss/wildfly/standalone/deployments/movieplex7-1.0-SNAPSHOT.war
RUN curl -L https://github.com/javaee-samples/javaee7-hol/blob/jrebel/solution/movieplex7-1.0-SNAPSHOT.war?raw=true -o /opt/jboss/wildfly/standalone/deployments/movieplex7-1.0-SNAPSHOT.war
