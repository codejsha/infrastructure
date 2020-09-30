#!/usr/bin/bash

USERNAME="admin"
PASSWORD="${PASSWORD}"
ACCESS_KEY="admin"
SECRET_KEY="SECRET_KEY"

NAMESPACE="registry-system"
kubectl create namespace ${NAMESPACE}

docker run --entrypoint htpasswd registry:2.7.0 -Bbn ${USERNAME} ${PASSWORD} > ./htpasswd

# helm install my-docker-registry \
helm upgrade --install my-docker-registry \
    --namespace ${NAMESPACE} \
    --set storage="s3" \
    --set secrets.htpasswd="$(cat ./htpasswd)" \
    --set secrets.s3.accessKey="${ACCESS_KEY}" \
    --set secrets.s3.secretKey="${SECRET_KEY}" \
    --set s3.region="us-east-1" \
    --set s3.regionEndpoint="http://minio.example.com" \
    --set s3.bucket="myimage" \
    --set s3.encrypt="false" \
    --set s3.secure="false" \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.annotations."nginx\.ingress\.kubernetes\.io/proxy-body-size"="0" \
    --set ingress.hosts={"registry.example.com"} \
    --set ingress.path="/" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --version 1.9.4 \
    stable/docker-registry

    ### for ip address
    # --set s3.regionEndpoint="http://10.10.10.52:9000" \
