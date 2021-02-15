#!/bin/bash

function install_cassandra_with_artifacthub {
    kubectl create --filename https://operatorhub.io/install/alpha/cassandra-operator.yaml
}

function install_cassandra_with_git {
    git clone https://github.com/instaclustr/cassandra-operator.git
    # gh repo clone instaclustr/cassandra-operator

    cd cassandra-operator
    kubectl apply --filename deploy/crds.yaml
    kubectl apply --filename deploy/bundle.yaml
}

######################################################################

# install_cassandra_with_artifacthub
install_cassandra_with_git
