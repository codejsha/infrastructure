#!/bin/bash

helm repo add oteemocharts https://oteemo.github.io/charts
helm repo update

NAMESPACE="nexus-system"

# helm install my-nexus \
helm upgrade --install my-nexus \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set statefulset.enabled="false" \
    --set replicaCount="1" \
    --set nexus.requests.cpu="250m" \
    --set nexus.requests.memory="4800Mi" \
    --set nexusBackup.enabled="true" \
    --set nexusBackup.env.targetBucket="s3://mynexus" \
    --set nexusBackup.persistence.enabled="true" \
    --set nexusBackup.persistence.storageClass="rook-ceph-block" \
    --set nexusBackup.persistence.storageSize="100Gi" \
    --set nexusProxy.enabled="true" \
    --set nexusProxy.env.nexusDockerHost="container.example.com" \
    --set nexusProxy.env.nexusHttpHost="nexus.example.com" \
    --set ingress.enabled="true" \
    --set ingress.tls.enabled="false" \
    --set ingress.annotations."kubernetes\.io/ingress\.allow-http"="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.path="/" \
    --set service.enabled="true" \
    --set service.type="ClusterIP" \
    --set service.ports[0].name="nexus" \
    --set service.ports[0].port="8081" \
    --set service.ports[0].targetPort="8081" \
    --set service.ports[1].name="nexus-docker-public" \
    --set service.ports[1].port="5003" \
    --set service.ports[1].targetPort="5003" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --set persistence.storageSize="100Gi" \
    --version 2.8.0 \
    oteemocharts/sonatype-nexus
