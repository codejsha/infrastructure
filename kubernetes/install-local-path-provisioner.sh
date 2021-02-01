#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
# kustomize build "github.com/rancher/local-path-provisioner/deploy?ref=master" | kubectl apply -f -
