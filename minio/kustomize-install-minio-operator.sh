#!/bin/bash

git clone https://github.com/minio/operator.git
# gh repo clone minio/operator

### install
kustomize build . | kubectl apply -f -

### uninstall
# kustomize build . | kubectl delete -f -
