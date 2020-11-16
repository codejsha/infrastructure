#!/usr/bin/bash

helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

NAMESPACE="vault-system"
kubectl create namespace ${NAMESPACE}

# helm install my-vault \
helm upgrade --install my-vault \
    --namespace ${NAMESPACE} \
    --set server.standalone.enabled="true" \
    --set server.auditStorage.enabled="true" \
    --set server.auditStorage.storageClass="rook-ceph-block" \
    \
    --set server.ui.enabled="true" \
    --set server.ingress.enabled="true" \
    --set server.ingress.annotations."kubernetes\.io/ingress\.class"="nginx" \
    --set server.ingress.hosts[0].host="vault.example.com" \
    --set server.ingress.hosts[0].path={"/"} \
    --set server.dataStorage.enabled="true" \
    --set server.dataStorage.storageClass="rook-ceph-block" \
    --version 0.6.0 \
    hashicorp/vault

    ### dev mode
    # --set server.dev.enabled="true" \
    # --set server.auditStorage.enabled="true" \
    # --set server.auditStorage.storageClass="rook-ceph-block" \
    ### standalone mode
    # --set server.standalone.enabled="true" \
    # --set server.auditStorage.enabled="true" \
    # --set server.auditStorage.storageClass="rook-ceph-block" \
    ### ha mode
    # --set server.ha.enabled="true" \
    # --set server.ha.replicas="3" \
    # --values override-ha.yaml \

# mkdir -p .vault
# kubectl exec -it my-vault-0 -- vault operator init > .vault/unseal_keys_and_root_token.txt
# kubectl exec -ti my-vault-0 -- vault operator unseal UNSEAL_KEY_1
# kubectl exec -ti my-vault-0 -- vault operator unseal UNSEAL_KEY_2
# kubectl exec -ti my-vault-0 -- vault operator unseal UNSEAL_KEY_3
