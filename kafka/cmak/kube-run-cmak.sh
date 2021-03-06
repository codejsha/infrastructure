#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

# ZK_HOSTS="my-kafka-zookeeper-headless:2181"
ZK_HOSTS="my-cluster-zookeeper-nodes:2181"

######################################################################

function kube_run_cmak {
    kubectl run \
        cmak \
        --restart=Never \
        --labels=app=cmak \
        --env="ZK_HOSTS=${ZK_HOSTS}" \
        --image=core.harbor.example.com/library/cmak:latest
}

function kube_run_cmak_attach {
    kubectl run \
        -it \
        --rm \
        cmak \
        --restart=Never \
        --labels=app=cmak \
        --env="ZK_HOSTS=${ZK_HOSTS}" \
        --image=core.harbor.example.com/library/cmak:latest
}

######################################################################

kube_run_cmak
# kube_run_cmak_attach
