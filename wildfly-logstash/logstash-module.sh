#!/bin/bash

JBOSS_HOME=/opt/jboss/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh

function wait_for_server() {
  until `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do
    sleep 1
  done
}

echo "=> Starting WildFly server"
$JBOSS_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 --admin-only &

echo "=> Waiting for the server to boot"
wait_for_server

$JBOSS_CLI -c << EOF

batch
# Add the module, replace the directory on the resources attribute to the path where you downloaded the jboss-logmanager-ext library
module add --name=org.jboss.logmanager.ext --dependencies=org.jboss.logmanager,javax.json.api,javax.xml.stream.api --resources=/opt/jboss/wildfly/jboss-logmanager-ext-1.0.0.Alpha3.jar

# Add the logstash formatter
/subsystem=logging/custom-formatter=logstash:add(class=org.jboss.logmanager.ext.formatters.LogstashFormatter,module=org.jboss.logmanager.ext)

# Add a socket-handler using the logstash formatter. Replace the hostname and port to the values needed for your logstash install
/subsystem=logging/custom-handler=logstash-handler:add(class=org.jboss.logmanager.ext.handlers.SocketHandler,module=org.jboss.logmanager.ext,named-formatter=logstash,properties={hostname=$HOST, port=5000})

# Add the new handler to the root-logger
/subsystem=logging/root-logger=ROOT:add-handler(name=logstash-handler)

# Reload the server which will boot the server into normal mode as well as write messages to logstash
run-batch
:reload

EOF

echo "=> Shutting down WildFly"
$JBOSS_CLI -c ":shutdown"

echo "=> Restarting WildFly"
$JBOSS_HOME/bin/standalone.sh -b 0.0.0.0
