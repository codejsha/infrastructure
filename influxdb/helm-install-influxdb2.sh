#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

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
    --set persistence.storageClass="standard" \
    influxdata/influxdb2

    ### rook ceph
    # --set persistence.storageClass="rook-ceph-block" \

    ### local path provisioner
    # --set persistence.storageClass="local-path" \
