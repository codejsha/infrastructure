#!/bin/bash

git clone https://github.com/spotify/backstage.git
# gh repo clone spotify/backstage

NAMESPACE="backstage-system"

function helm_install_backstage {
    helm install my-backstage \
        --create-namespace \
        --namespace ${NAMESPACE} \
        --dependency-update \
        --values values.yaml \
        ./backstage/contrib/chart/backstage
}

function helm_upgrade_install_backstage {
    helm upgrade --install my-backstage \
        --create-namespace \
        --namespace ${NAMESPACE} \
        --values values.yaml \
        ./backstage/contrib/chart/backstage
}

helm_install_backstage
# helm_upgrade_install_backstage
