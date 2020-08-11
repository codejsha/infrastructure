#!/usr/bin/bash

helm repo add oteemocharts https://oteemo.github.io/charts
helm repo update

NAMESPACE="nexus-system"
kubectl create namespace ${NAMESPACE}

helm install my-nexus \
    --namespace ${NAMESPACE} \
    --set nexus.requests.cpu="250m" \
    --set nexus.requests.memory="4800Mi" \
    --set nexusBackup.enabled="true" \
    --set nexusBackup.env.targetBucket="s3://mynexus" \
    --set nexusBackup.persistence.enabled="true" \
    --set nexusBackup.persistence.storageClass="rook-ceph-block" \
    --set nexusBackup.persistence.storageSize="100Gi" \
    --set nexusProxy.enabled="true" \
    --set nexusProxy.env.nexusDockerHost="container.kube.example.com" \
    --set nexusProxy.env.nexusHttpHost="nexus.kube.example.com" \
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
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --set persistence.storageSize="100Gi" \
    --version 2.5.0 \
    oteemocharts/sonatype-nexus
