#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

STRIMZI_VERSION="0.20.1"
STRIMZI_OPERATOR_NAMESPACE="kafka-operator"
STRIMZI_NAMESPACE="kafka-system"

######################################################################

function create_namespaces {
    kubectl create namespace ${STRIMZI_OPERATOR_NAMESPACE}
    kubectl create namespace ${STRIMZI_NAMESPACE}
}

function download_install_file {
    if [ ! -f "strimzi-${STRIMZI_VERSION}.zip" ]; then
        curl \
            --output strimzi-${STRIMZI_VERSION}.zip \
            --location \
            --remote-header-name \
            --remote-name \
            https://github.com/strimzi/strimzi-kafka-operator/releases/download/${STRIMZI_VERSION}/strimzi-${STRIMZI_VERSION}.zip
        # curl \
        #     --output strimzi-${STRIMZI_VERSION}.tar.gz \
        #     --location \
        #     --remote-header-name \
        #     --remote-name \
        #     https://github.com/strimzi/strimzi-kafka-operator/releases/download/${STRIMZI_VERSION}/strimzi-${STRIMZI_VERSION}.tar.gz
    fi
}

function extract_install_file {
    unzip strimzi-${STRIMZI_VERSION}.zip
    # tar -xzf strimzi-${STRIMZI_VERSION}.tar.gz
}

function deploy_resource {
    sed -i "s/namespace: .*/namespace: ${STRIMZI_OPERATOR_NAMESPACE}/" \
        strimzi-${STRIMZI_VERSION}/install/cluster-operator/*RoleBinding*.yaml
    kubectl apply \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/ \
        -n ${STRIMZI_OPERATOR_NAMESPACE}
    # kubectl apply \
    #     --filename strimzi-${STRIMZI_VERSION}/install/strimzi-admin/ \
    #     -n ${STRIMZI_OPERATOR_NAMESPACE}
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

function create_entity_operator {
    kubectl apply \
        --filename strimzi-${STRIMZI_VERSION}/install/topic-operator/ \
        -n ${STRIMZI_NAMESPACE}
    kubectl apply \
        --filename strimzi-${STRIMZI_VERSION}/install/user-operator/ \
        -n ${STRIMZI_NAMESPACE}
}

function delete_strimzi_operator {
    kubectl delete \
        --filename strimzi-${STRIMZI_VERSION}/install/topic-operator/ \
        -n ${STRIMZI_NAMESPACE}
    kubectl delete \
        --filename strimzi-${STRIMZI_VERSION}/install/user-operator/ \
        -n ${STRIMZI_NAMESPACE}

    kubectl delete \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/020-RoleBinding-strimzi-cluster-operator.yaml \
        -n ${STRIMZI_NAMESPACE}
    kubectl delete \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/032-RoleBinding-strimzi-cluster-operator-topic-operator-delegation.yaml \
        -n ${STRIMZI_NAMESPACE}
    kubectl delete \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/031-RoleBinding-strimzi-cluster-operator-entity-operator-delegation.yaml \
        -n ${STRIMZI_NAMESPACE}

    kubectl delete \
        --filename strimzi-${STRIMZI_VERSION}/install/cluster-operator/ \
        -n ${STRIMZI_OPERATOR_NAMESPACE}
    # kubectl delete \
    #     --filename strimzi-${STRIMZI_VERSION}/install/strimzi-admin/ \
    #     -n ${STRIMZI_OPERATOR_NAMESPACE}
}

######################################################################

create_namespaces
download_install_file
extract_install_file
deploy_resource
give_permission_to_strimzi_operator
# create_entity_operator
# delete_strimzi_operator
