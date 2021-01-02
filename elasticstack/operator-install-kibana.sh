#!/bin/bash

cat <<EOF | kubectl apply -f -
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: elasticstack
spec:
  version: 7.10.1
  count: 1
  elasticsearchRef:
    name: elasticstack
EOF
