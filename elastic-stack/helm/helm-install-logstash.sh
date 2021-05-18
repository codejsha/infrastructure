#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

NAMESPACE="elastic-system"

# helm install my-logstash \
helm upgrade --install my-logstash \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set logstashJavaOpts="-Xms512m -Xmx512m" \
    --set service.type="ClusterIP" \
    --set service.ports[0].name="beats" \
    --set service.ports[0].port="5044" \
    --set service.ports[0].protocol="TCP" \
    --set service.ports[0].targetPort="5044" \
    --set service.ports[1].name="http" \
    --set service.ports[1].port="8080" \
    --set service.ports[1].protocol="TCP" \
    --set service.ports[1].targetPort="8080" \
    --set persistence.enabled="true" \
    --set volumeClaimTemplate.storageClassName="standard" \
    --version 7.8.0 \
    elastic/logstash

    ### rook ceph
    # --set volumeClaimTemplate.storageClassName="rook-ceph-block" \

    ### local path provisioner
    # --set volumeClaimTemplate.storageClassName="local-path" \
