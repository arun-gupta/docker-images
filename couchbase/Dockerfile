FROM couchbase:latest

COPY configure-node.sh /opt/couchbase

HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:8091/pools || exit 1

CMD ["/opt/couchbase/configure-node.sh"]

