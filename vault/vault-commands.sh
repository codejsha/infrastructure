######################################################################

export VAULT_TOKEN="$(cat ~/.vault/root_token.txt)"
export VAULT_ADDR="http://vault.example.com"

######################################################################

VAULT_PODNAME="$(kubectl get pods -l app.kubernetes.io/name=vault -o custom-columns=:metadata.name)"
kubectl exec -it ${VAULT_PODNAME} -c vault -- /bin/sh

######################################################################

### enable kubernetes authentication method
vault auth enable kubernetes
