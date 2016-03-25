cmd=`curl -u Administrator:password http://${COUCHBASE_URI}:8091/pools/default/buckets/travel-sample 2>/dev/null | jq .basicStats.itemCount`

while [ -z $cmd ]; do
  cmd=`curl -u Administrator:password http://${COUCHBASE_URI}:8091/pools/default/buckets/travel-sample 2>/dev/null | jq .basicStats.itemCount`
  echo "(" `date` ") Waiting (1) ... value=$cmd"
  sleep 1
done

while [ $cmd -ne "31569" ]; do
  cmd=`curl -u Administrator:password http://${COUCHBASE_URI}:8091/pools/default/buckets/travel-sample 2>/dev/null | jq .basicStats.itemCount`
  echo "(" `date` ") Waiting (2) ... value=$cmd"
  sleep 2
done

echo "Completed: $cmd records found"

