#!/bin/bash

function operator_install_cassandra_with_artifacthub {
    kubectl create --filename https://operatorhub.io/install/alpha/cassandra-operator.yaml
}

function operator_install_cassandra_with_git {
    git clone https://github.com/instaclustr/cassandra-operator.git
    # gh repo clone instaclustr/cassandra-operator

    cd cassandra-operator
    kubectl apply --filename deploy/crds.yaml
    kubectl apply --filename deploy/bundle.yaml
}

######################################################################

# operator_install_cassandra_with_artifacthub
operator_install_cassandra_with_git
