#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### create
kind create cluster --name kind --config cluster.yaml
# kind create cluster --name kind --config cluster-ha.yaml

### root
# sudo /usr/local/bin/kind create cluster --name kind --config cluster.yaml
# sudo /usr/local/bin/kind create cluster --name kind --config cluster-ha.yaml

### delete
# kind delete cluster --name kind
