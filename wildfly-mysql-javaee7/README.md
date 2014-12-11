Example showing usage of CLI to modify the WildFly configuration.

## Build

    docker build --rm --tag wildfly-config-cli `dirname "$0"`

## Run

    docker run -it --rm wildfly-config-cli


```
$ docker run -it --rm wildfly-config-cli

[SNIP]

10:03:53,676 INFO  [org.jboss.as.connector.subsystems.datasources] (MSC service thread 1-5) JBAS010400: Bound data source [java:jboss/datasources/ExampleMySQLDS]
10:03:53,677 INFO  [org.jboss.as.connector.subsystems.datasources] (MSC service thread 1-5) JBAS010400: Bound data source [java:jboss/datasources/ExampleDS]
10:03:53,834 INFO  [org.jboss.ws.common.management] (MSC service thread 1-3) JBWS022052: Starting JBoss Web Services - Stack CXF Server 4.3.2.Final
10:03:54,018 INFO  [org.jboss.as] (Controller Boot Thread) JBAS015961: Http management interface listening on http://127.0.0.1:9990/management
10:03:54,019 INFO  [org.jboss.as] (Controller Boot Thread) JBAS015951: Admin console listening on http://127.0.0.1:9990
10:03:54,019 INFO  [org.jboss.as] (Controller Boot Thread) JBAS015874: WildFly 8.2.0.Final "Tweek" started in 2999ms - Started 190 of 240 services (82 services are lazy, passive or on-demand)
```
