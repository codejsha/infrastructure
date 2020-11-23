#!/bin/bash

NAMESPACE="cassandra-system"

# helm install my-cassandra \
helm upgrade --install my-cassandra \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set config.cluster_size="3" \
    --set config.heap_new_size="512M" \
    --set config.max_heap_size="2048M" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --version 0.15.2 \
    incubator/cassandra

### status
# kubectl exec -it --namespace ${NAMESPACE} \
#     $(kubectl get pods --namespace ${NAMESPACE} \
#         -l app=cassandra -o jsonpath='{.items[0].metadata.name}') \
#     nodetool status
