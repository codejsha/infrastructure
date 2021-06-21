#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

### create
kind create cluster --name kind --config cluster.yaml
# kind create cluster --name kind --config cluster-ha.yaml

### root
# sudo /usr/local/bin/kind create cluster --name kind --config cluster.yaml
# sudo /usr/local/bin/kind create cluster --name kind --config cluster-ha.yaml

### delete
# kind delete cluster --name kind
