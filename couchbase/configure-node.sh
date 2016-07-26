set -m

/entrypoint.sh couchbase-server &

sleep 15

INTERNAL_IP=$(hostname -i)

# Setup index and memory quota
curl -v -X POST http://$INTERNAL_IP:8091/pools/default -d memoryQuota=300 -d indexMemoryQuota=300

# Setup services
curl -v http://$INTERNAL_IP:8091/node/controller/setupServices -d services=kv%2Cn1ql%2Cindex

# Setup credentials
curl -v http://$INTERNAL_IP:8091/settings/web -d port=8091 -d username=Administrator -d password=password

# Setup Memory Optimized Indexes
curl -i -u Administrator:password -X POST http://$INTERNAL_IP:8091/settings/indexes -d 'storageMode=memory_optimized'

# Load travel-sample bucket
#curl -v -u Administrator:password -X POST http://$INTERNAL_IP:8091/sampleBuckets/install -d '["travel-sample"]'

echo "Type: $TYPE, Master: $COUCHBASE_MASTER"

if [ "$TYPE" = "worker" ]; then
  sleep 15
  set IP=`hostname -I`
  couchbase-cli server-add --cluster=$COUCHBASE_MASTER:8091 --user Administrator --password password --server-add=$IP
  # TODO: Hack with the cuts, use jq may be better.
  #KNOWN_NODES=`curl -X POST -u Administrator:password http://$COUCHBASE_MASTER:8091/controller/addNode \
  #  -d hostname=$IP -d user=Administrator -d password=password -d services=kv,n1ql,index | cut -d: -f2 | cut -d\" -f 2 | sed -e   's/@/%40/g'`

  if [ "$AUTO_REBALANCE" = "true" ]; then
    echo "Auto Rebalance: $AUTO_REBALANCE"
    sleep 10
    couchbase-cli rebalance -c $COUCHBASE_MASTER:8091 -u Administrator -p password --server-add=$IP
    #curl -v -X POST -u Administrator:password http://$COUCHBASE_MASTER:8091/controller/rebalance --data "knownNodes=$KNOWN_NODES&ejectedNodes="
  fi;
fi;

fg 1

