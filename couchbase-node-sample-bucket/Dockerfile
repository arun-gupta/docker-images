FROM couchbase

COPY create-load-bucket.sh /opt/couchbase
COPY data /opt/couchbase

CMD ["/opt/couchbase/create-load-bucket.sh"]

