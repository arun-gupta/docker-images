= Docker Containers using Bridge and Overlay Network

This is a Java EE application deployed on WildFly and uses MySQL database.

== Docker Containers using Bridge Network

```console
docker-compose --x-networking up -d
```

== Docker Containers using Overlay Network

More details: http://blog.arungupta.me/docker-container-linking-across-multiple-hosts-techtip69/

== Tips

. Build the image locally: `docker build -t arungupta/wildfly-mysql-javaee7 .`
. Log into the container: `sudo docker exec -it mysqldb bash`
. Find IP address of the container: `sudo docker inspect -f '{{ .NetworkSettings.IPAddress }}' mysqldb`

