# Enables job control
set -m

# Enables error propagation 
set -e

/entrypoint.sh couchbase-server &

sleep 15

curl --fail -v -X POST http://127.0.0.1:8091/pools/default -d memoryQuota=300 -d indexMemoryQuota=300
curl --fail -v http://127.0.0.1:8091/node/controller/setupServices -d services=kv%2Cn1ql%2Cindex
curl --fail -v http://127.0.0.1:8091/settings/web -d port=8091 -d username=Administrator -d password=password

fg 1

