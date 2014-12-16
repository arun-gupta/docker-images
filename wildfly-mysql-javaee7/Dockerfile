FROM jboss/wildfly:latest

ADD customization /opt/jboss/wildfly/customization/
ADD modules /opt/jboss/wildfly/modules/
ADD employees.war /opt/jboss/

RUN /opt/jboss/wildfly/customization/execute.sh

