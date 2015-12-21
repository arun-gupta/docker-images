# Use latest jboss/base-jdk:8 image as the base
FROM jboss/base-jdk:8

# Set the JBOSS_VERSION env variable
ENV JBOSS_VERSION 7.0.0.Beta
ENV JBOSS_HOME /opt/jboss/jboss-eap-7.0/

COPY jboss-eap-$JBOSS_VERSION.zip $HOME

# Add the JBoss distribution to /opt, and make jboss the owner of the extracted zip content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && unzip jboss-eap-$JBOSS_VERSION.zip \
    && rm jboss-eap-$JBOSS_VERSION.zip

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
EXPOSE 8080 9990

# Set the default command to run on boot
# This will boot JBoss EAP in the standalone mode and bind to all interface
CMD ["/opt/jboss/jboss-eap-7.0/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

