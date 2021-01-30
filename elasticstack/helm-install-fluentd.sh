#!/bin/bash

NAMESPACE="elastic-system"

# helm install my-fluentd \
helm upgrade --install my-fluentd \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set output.host="elasticsearch-master" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="local-path" \
    --version 2.4.2 \
    stable/fluentd

    ### rook ceph
    # --set persistence.storageClass="rook-ceph-block" \
