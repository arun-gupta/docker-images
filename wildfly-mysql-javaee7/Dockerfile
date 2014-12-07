FROM jboss/wildfly:latest
#FROM arungupta/wildfly-centos

ADD employees.war /opt/jboss/employees.war
ADD temp.war /opt/jboss/temp.war
ADD customization /opt/jboss/wildfly/customization/

CMD ["/opt/jboss/wildfly/customization/execute.sh"]

