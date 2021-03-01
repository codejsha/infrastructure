#!/bin/bash

helm repo add influxdata https://helm.influxdata.com
helm repo update

PASSWORD="${PASSWORD}"

NAMESPACE="influx-system"

# helm install my-influxdb \
helm upgrade --install my-influxdb \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set adminUser.user="admin" \
    --set adminUser.password="${PASSWORD}" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    influxdata/influxdb2

    ### local path provisioner
    # --set persistence.storageClass="local-path" \
