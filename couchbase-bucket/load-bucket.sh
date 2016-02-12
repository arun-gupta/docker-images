# Enables job control
set -m

# Enables error propagation 
set -e

apt-get update
apt-get install -y unzip

mkdir -p /opt/couchbase/data/docs
cd /opt/couchbase/data
wget http://jsonstudio.com/wp-content/uploads/2014/02/zips.zip
unzip zips.zip
cd docs
split -l 1 -a 4 ../zips.json
for file in *
do
  sed -i 's/_id/uuid/g' "$file"
  mv "$file" "$file.json"
done

/entrypoint.sh couchbase-server &

sleep 15

curl --fail -v -X POST http://127.0.0.1:8091/pools/default -d memoryQuota=300 -d indexMemoryQuota=300
curl --fail -v http://127.0.0.1:8091/node/controller/setupServices -d services=kv%2Cn1ql%2Cindex
curl --fail -v http://127.0.0.1:8091/settings/web -d port=8091 -d username=Administrator -d password=password

#Create the bucket
couchbase-cli bucket-create -c 127.0.0.1 --bucket=sample --bucket-ramsize=200 -u Administrator -p password

#Break the big document into multiple documents
cbdocloader -u Administrator -p password -n 127.0.0.1:8091 -b sample -s 100 /opt/couchbase/data

fg 1

