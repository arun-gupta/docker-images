FROM couchbase

COPY load-bucket.sh /opt/couchbase
COPY data /opt/couchbase/data

CMD ["/opt/couchbase/load-bucket.sh"]

