#!/bin/bash

function kube_run_cmak {
    kubectl run \
        cmak \
        --restart=Never \
        --labels=app=cmak \
        --env="ZK_HOSTS=my-kafka-zookeeper-headless:2181" \
        --image=core.harbor.example.com/library/cmak:latest
}

function kube_run_cmak_attach {
    kubectl run \
        --stdin \
        --tty \
        --rm \
        cmak \
        --restart=Never \
        --labels=app=cmak \
        --env="ZK_HOSTS=my-kafka-zookeeper-headless:2181" \
        --image=core.harbor.example.com/library/cmak:latest
}

######################################################################

kube_run_cmak
# kube_run_cmak_attach
