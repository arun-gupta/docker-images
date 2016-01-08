#!/bin/bash

# Docker Machine for Consul
docker-machine \
  create 
  -d virtualbox \
  consul-machine

# Start Consul
docker $(docker-machine config consul-machine) run -d --restart=always \
        -p "8500:8500" \
        -h "consul" \
        progrium/consul -server -bootstrap

# Docker Swarm master
docker-machine \
  create \
  -d virtualbox \
  --virtualbox-disk-size "5000" \
  --swarm \
  --swarm-master \
  --swarm-discovery="consul://$(docker-machine ip consul-machine):8500" \
  --engine-opt="cluster-store=consul://$(docker-machine ip consul-machine):8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  swarm-master

# Docker Swarm node-01
docker-machine /
  create /
  -d virtualbox /
  --virtualbox-disk-size "5000" /
  --swarm /
  --swarm-discovery="consul://$(docker-machine ip consul-machine):8500" /
  --engine-opt="cluster-store=consul://$(docker-machine ip consul-machine):8500" /
  --engine-opt="cluster-advertise=eth1:2376" /
  swarm-node-01

# Docker Swarm node-02
docker-machine /
  create /
  -d virtualbox /
  --virtualbox-disk-size "5000" /
  --swarm /
  --swarm-discovery="consul://$(docker-machine ip consul-machine):8500" /
  --engine-opt="cluster-store=consul://$(docker-machine ip consul-machine):8500" /
  --engine-opt="cluster-advertise=eth1:2376" /
  swarm-node-02

# Configure to use Docker Swarm cluster
eval "$(docker-machine env --swarm swarm-master)"

# Create an overlay network
docker /
  network /
  create /
  -d overlay /
  couchbase-net

# No docs on how to use port filter on overlay network?? Question for Dave

Port filter example in Bridge mode is slightly confusing. For example, Bridge network is restricted to single host. So why would somebody 
create a Swarm with bridge network? Even if you do, its not clear how Swarm would pick the right node with the available port, especially
since all the ports are not even configured in an overlay network.

# Start one instance of Couchbase
docker run -d --net=couchbase-net -p 8091-8093:8091-8093 -p 11210:11210 arungupta/couchbase-node

# Start second instance of Couchbase
docker run -d --net=couchbase-net -p 8091-8093:8091-8093 -p 11210:11210 arungupta/couchbase-node

# Start third instance of Couchbase
docker run -d --net=couchbase-net -p 8091-8093:8091-8093 -p 11210:11210 arungupta/couchbase-node

# Get IP address of the container on swarm-master
IP1=docker inspect --format '{{ .NetworkSettings.IPAddress }}' {CID}

# Get IP address of the container on swarm-node-01
IP2

# Get IP address of the container on swarm-node-02
IP3

# Configure Couchbase cluster
curl -X POST -u Administrator:password http://IP1:8091/controller/addNode -d hostname=IP2 -d user=Administrator -d password=password -d services=kv,n1ql,index -o O1
{"otpNode":"ns_1@172.17.0.4"}
curl -X POST -u Administrator:password http://IP1:8091/controller/addNode -d hostname=IP3 -d user=Administrator -d password=password -d services=kv,n1ql,index -o O2
{"otpNode":"ns_1@172.17.0.5"}

# Rebalance the cluster:
curl -v -X POST -u Administrator:password http://IP1:8091/controller/rebalance --data 'knownNodes=ns_1%40172.17.0.3%2Cns_1%40172.17.0.4 %2Cns_1%40172.17.0.5&ejectedNodes='



