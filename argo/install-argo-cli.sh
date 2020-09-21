#!/usr/bin/bash

ARGO_VERSION="v2.10.1"

curl -sLO https://github.com/argoproj/argo/releases/download/${ARGO_VERSION}/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
sudo mv ./argo-linux-amd64 /usr/local/bin/argo
sudo chown root:root /usr/local/bin/argo

argo version
