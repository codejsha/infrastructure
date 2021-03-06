#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

# minikube config set memory 10240
# minikube config set memory 16384
minikube config set memory 32768
minikube config set cpus 4
