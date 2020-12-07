#!/bin/bash

STRIMZI_VERSION="0.20.0"
STRIMZI_OPERATOR_NAMESPACE="kafka-operator"
STRIMZI_NAMESPACE="kafka-system"

######################################################################

function create_strimzi_namespaces {
    kubectl create namespace ${STRIMZI_OPERATOR_NAMESPACE}
    kubectl create namespace ${STRIMZI_NAMESPACE}
}

function download_strimzi_operator_install_file {
    curl \
        --output strimzi-${STRIMZI_VERSION}.tar.gz \
        --location \
        --remote-header-name \
        --remote-name \
        https://github.com/strimzi/strimzi-kafka-operator/releases/download/${STRIMZI_VERSION}/strimzi-${STRIMZI_VERSION}.tar.gz
}

function extract_strimzi_operator_install_file {
    tar -xzf strimzi-${STRIMZI_VERSION}.tar.gz
}

function deploy_strimzi_resources {
    sed -i 's/namespace: .*/namespace: ${STRIMZI_OPERATOR_NAMESPACE}/' \
        strimzi-${STRIMZI_VERSION}/install/cluster-operator/*RoleBinding*.yaml
    kubectl apply \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/ \
        -n ${STRIMZI_OPERATOR_NAMESPACE}
}

function give_permission_to_strimzi_operator {
    kubectl apply \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/020-RoleBinding-strimzi-cluster-operator.yaml \
        -n ${STRIMZI_NAMESPACE}
    kubectl apply \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/032-RoleBinding-strimzi-cluster-operator-topic-operator-delegation.yaml \
        -n ${STRIMZI_NAMESPACE}
    kubectl apply \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/031-RoleBinding-strimzi-cluster-operator-entity-operator-delegation.yaml \
        -n ${STRIMZI_NAMESPACE}
}

function create_kafka_cluster {
    kubectl apply \
        --filename strimzi-kafka-cluster.yaml \
        -n ${STRIMZI_NAMESPACE}
}

######################################################################

create_strimzi_namespaces
download_strimzi_operator_install_file
extract_strimzi_operator_install_file
deploy_strimzi_resources
give_permission_to_strimzi_operator
create_kafka_cluster
