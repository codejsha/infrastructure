#!/bin/bash
# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html
# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html
# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-volume-claim-templates.html

kubectl apply -f https://download.elastic.co/downloads/eck/1.1.2/all-in-one.yaml
kubectl logs -f statefulset.apps/elastic-operator -n elastic-system

### quickstart with volume claim templates
# cat <<EOF | kubectl apply -f -
# apiVersion: elasticsearch.k8s.elastic.co/v1
# kind: Elasticsearch
# metadata:
#   name: quickstart
# spec:
#   version: 7.8.0
#   nodeSets:
#   - name: default
#     count: 1
#     config:
#       node.master: true
#       node.data: true
#       node.ingest: true
#       node.store.allow_mmap: false
#     volumeClaimTemplates:
#     - metadata:
#         name: elasticsearch-data
#       spec:
#         accessModes:
#         - ReadWriteOnce
#         resources:
#           requests:
#             storage: 5Gi
#         storageClassName: rook-ceph-block
# EOF

### kibana
# cat <<EOF | kubectl apply -f -
# apiVersion: kibana.k8s.elastic.co/v1
# kind: Kibana
# metadata:
#   name: quickstart
# spec:
#   version: 7.8.0
#   count: 1
#   elasticsearchRef:
#     name: quickstart
# EOF
