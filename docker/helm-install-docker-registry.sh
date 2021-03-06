#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

USERNAME="admin"
PASSWORD="${PASSWORD}"
AWS_ACCESS_KEY="${AWS_ACCESS_KEY}"
AWS_SECRET_KEY="${AWS_SECRET_KEY}"

NAMESPACE="registry-system"

docker container run --entrypoint htpasswd registry:2.7.0 -Bbn ${USERNAME} ${PASSWORD} > ./htpasswd

# helm install my-docker-registry \
helm upgrade --install my-docker-registry \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set storage="s3" \
    --set secrets.htpasswd="$(cat ./htpasswd)" \
    --set secrets.s3.accessKey="${AWS_ACCESS_KEY}" \
    --set secrets.s3.secretKey="${AWS_SECRET_KEY}" \
    --set s3.region="us-west-1" \
    --set s3.regionEndpoint="http://minio.example.com" \
    --set s3.bucket="myimage" \
    --set s3.encrypt="false" \
    --set s3.secure="false" \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set-string ingress.annotations."nginx\.ingress\.kubernetes\.io/proxy-body-size"="0" \
    --set ingress.hosts={"registry.example.com"} \
    --set ingress.path="/" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="standard" \
    --version 1.9.6 \
    stable/docker-registry

    ### rook ceph
    # --set persistence.storageClass="rook-ceph-block" \

    ### local path provisioner
    # --set persistence.storageClass="local-path" \

    ### minio
    # --set s3.regionEndpoint="http://10.10.10.52:9000" \
    # --set s3.regionEndpoint="https://minio-tenant-1.example.com" \
