#!/bin/bash
#set -x

# Docker Machine for Consul
docker-machine \
  create \
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
docker-machine \
  create \
  -d virtualbox \
  --virtualbox-disk-size "5000" \
  --swarm \
  --swarm-discovery="consul://$(docker-machine ip consul-machine):8500" \
  --engine-opt="cluster-store=consul://$(docker-machine ip consul-machine):8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  swarm-node-01

# Docker Swarm node-02
docker-machine \
  create \
  -d virtualbox \
  --virtualbox-disk-size "5000" \
  --swarm \
  --swarm-discovery="consul://$(docker-machine ip consul-machine):8500" \
  --engine-opt="cluster-store=consul://$(docker-machine ip consul-machine):8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  swarm-node-02

# Configure to use Docker Swarm cluster
eval "$(docker-machine env --swarm swarm-master)"

# Create an overlay network
docker \
  network \
  create \
  -d overlay \
  couchbase-net

# Swarm will ensure that Couchbase is started on a node where port is available

# Start three instances of Couchbase
for i in {1..3}
do
  docker \
    run \
    -d \
    --net=couchbase-net \
    -p 8091-8093:8091-8093 \
    -p 11210:11210 \
    arungupta/couchbase-node
done

# Get IP address of the Couchbase containers from Docker Swarm
eval "$(docker-machine env --swarm swarm-master)"
declare -a ip
count=0
for i in `docker ps -q`
do
  ip[$count]=`docker inspect --format '{{ index .NetworkSettings.Ports "8091/tcp" 0 "HostIp" }}' $i`
  ((count++))
done

echo ${ip[0]} .. ${ip[1]} .. ${ip[2]}

# # Configure Couchbase cluster
# curl -X POST -u Administrator:password http://IP1:8091/controller/addNode -d hostname=IP2 -d user=Administrator -d password=password -d services=kv,n1ql,index -o O1
# {"otpNode":"ns_1@172.17.0.4"}
# curl -X POST -u Administrator:password http://IP1:8091/controller/addNode -d hostname=IP3 -d user=Administrator -d password=password -d services=kv,n1ql,index -o O2
# {"otpNode":"ns_1@172.17.0.5"}

#curl -X GET -u Administratator:password http://IP1:8091/pools/default 

# # Rebalance the cluster:
# curl -v -X POST -u Administrator:password http://IP1:8091/controller/rebalance --data 'knownNodes=ns_1%40172.17.0.3%2Cns_1%40172.17.0.4 %2Cns_1%40172.17.0.5&ejectedNodes='

