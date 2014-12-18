FROM jboss/wildfly:latest

ADD customization /opt/jboss/wildfly/customization/

RUN /opt/jboss/wildfly/customization/execute.sh

ADD employees.war /opt/jboss/wildfly/standalone/deployments/employees.war


