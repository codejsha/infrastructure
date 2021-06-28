#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

PASSWORD="${PASSWORD}"

NAMESPACE="mssql-system"

# helm install my-mssql \
helm upgrade --install my-mssql \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set acceptEula.value="Y" \
    --set edition.value="Developer" \
    --set collation="SQL_Latin1_General_100_CI_AS_SC" \
    --set sapassword="${PASSWORD}" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="standard" \
    --set service.type="LoadBalancer" \
    --set service.loadBalancerIP="10.10.10.91" \
    --version 0.11.2 \
    stable/mssql-linux

    ### rook ceph
    # --set persistence.storageClass="rook-ceph-block" \

    ### local path provisioner
    # --set persistence.storageClass="local-path" \
