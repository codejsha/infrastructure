#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

### resource
# minikube config set memory 10240
minikube config set memory 16384
# minikube config set memory 32768
minikube config set cpus 4

### driver
# minikube config set driver none

### podman
# minikube config set driver podman
# minikube config set container-runtime cri-o
