#!/bin/bash

helm repo add drone https://charts.drone.io
helm repo update

if [ ! -f "SHARED_SECRET.txt" ]; then
    echo "$(openssl rand -hex 16)" > SHARED_SECRET.txt
fi

SHARED_SECRET="$(cat SHARED_SECRET.txt)"

NAMESPACE="drone-system"

# helm install my-drone \
helm upgrade --install my-drone \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set ingress.enabled="true" \
    --set ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set ingress.hosts[0].host="drone.example.com" \
    --set ingress.hosts[0].paths[0]="/" \
    --set persistentVolume.storageClass="local-path" \
    --set env.DRONE_SERVER_HOST="drone.example.com" \
    --set env.DRONE_RPC_SECRET="${SHARED_SECRET}" \
    --version 0.1.6 \
    drone/drone

    ### self-hosted git
    # --set env.DRONE_GIT_ALWAYS_AUTH="true" \

    ### github
    # --set env.DRONE_GITHUB_CLIENT_ID="" \
    # --set env.DRONE_GITHUB_CLIENT_SECRET="" \

    ### gitlab
    # --set env.DRONE_GITLAB_CLIENT_ID="" \
    # --set env.DRONE_GITLAB_CLIENT_SECRET="" \
    # --set env.DRONE_GITLAB_SERVER="" \

    ### rook ceph
    # --set persistentVolume.storageClass="rook-ceph-block" \
