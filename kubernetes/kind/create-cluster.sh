#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

### create
# kind create cluster --name kind --config cluster.yaml
kind create cluster --name kind --config cluster-ha.yaml

### delete
# kind delete cluster --name kind
