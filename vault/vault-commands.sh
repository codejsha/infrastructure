######################################################################

export VAULT_TOKEN="$(cat ~/.vault/root_token.txt)"
export VAULT_ADDR="http://vault.example.com"

######################################################################

mkdir -p ~/.vault
kubectl exec -it my-vault-0 -- vault operator init > ~/.vault/unseal_keys_and_root_token.txt
cat ~/.vault/unseal_keys_and_root_token.txt

# kubectl exec -it my-vault-0 -- vault operator unseal
kubectl exec -it my-vault-0 -- vault operator unseal <UNSEAL_KEY_1>
kubectl exec -it my-vault-0 -- vault operator unseal <UNSEAL_KEY_2>
kubectl exec -it my-vault-0 -- vault operator unseal <UNSEAL_KEY_3>

######################################################################

### default namespace
VAULT_PODNAME="$(kubectl get pods --namespace default --selector app.kubernetes.io/name=vault --output custom-columns=:metadata.name)"
VAULT_PODNAME="$(kubectl get pods -n default -l app.kubernetes.io/name=vault -o custom-columns=:metadata.name)"
kubectl exec -it --namespace default ${VAULT_PODNAME} --container vault -- /bin/sh

### vault-system namespace
VAULT_PODNAME="$(kubectl get pods --namespace vault-system --selector app.kubernetes.io/name=vault --output custom-columns=:metadata.name)"
VAULT_PODNAME="$(kubectl get pods -n vault-system -l app.kubernetes.io/name=vault -o custom-columns=:metadata.name)"
kubectl exec -it --namespace vault-system ${VAULT_PODNAME} --container vault -- /bin/sh

######################################################################

vault operator rekey

######################################################################

### enable kubernetes authentication method
vault auth enable kubernetes

vault write auth/kubernetes/config \
   token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
   kubernetes_host="https://10.10.10.11:6443" \
   kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
vault write auth/kubernetes/config \
   token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
   kubernetes_host="https://192.168.140.11:6443" \
   kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

######################################################################

### kv

vault secrets enable -path=infra kv-v2
vault secrets enable -path=internal kv-v2

######################################################################

### pki

vault secrets enable pki
vault secrets tune -max-lease-ttl=8760h pki

vault write pki/root/generate/internal \

vault write pki/config/urls \
    issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
    crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"

vault policy write pki - <<EOF
path "pki*"                        { capabilities = ["read", "list"] }
path "pki/roles/*"   { capabilities = ["create", "update"] }
path "pki/sign/*"    { capabilities = ["create", "update"] }
path "pki/issue/*"   { capabilities = ["create"] }
EOF
