#!/bin/bash

helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

NAMESPACE="vault-system"

# helm install my-vault \
helm upgrade --install my-vault \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --values helm-chart-values.yaml \
    --values helm-chart-values-standalone.yaml \
    --version 0.9.1 \
    hashicorp/vault

    ### dev mode
    # --values helm-chart-values-dev.yaml \
    ### standalone mode
    # --values helm-chart-values-standalone.yaml \
    ### ha mode
    # --values helm-chart-values-ha.yaml \

# mkdir -p .vault
# kubectl exec -it my-vault-0 -- vault operator init > .vault/unseal_keys_and_root_token.txt
# kubectl exec -ti my-vault-0 -- vault operator unseal UNSEAL_KEY_1
# kubectl exec -ti my-vault-0 -- vault operator unseal UNSEAL_KEY_2
# kubectl exec -ti my-vault-0 -- vault operator unseal UNSEAL_KEY_3
