#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

helm repo add elastic https://helm.elastic.co
helm repo update

NAMESPACE="elastic-system"

helm upgrade --install my-elasticsearch \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set esJavaOpts="-Xms512m -Xmx512m" \
    --set volumeClaimTemplate.storageClassName="standard" \
    --version 7.8.0 \
    elastic/elasticsearch

    ### rook ceph
    # --set volumeClaimTemplate.storageClassName="rook-ceph-block" \

    ### local path provisioner
    # --set volumeClaimTemplate.storageClassName="local-path" \