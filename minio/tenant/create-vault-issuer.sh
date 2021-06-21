#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

kubectl create serviceaccount --namespace minio-tenant issuer

ISSUER_SECRET_REF="$(kubectl get serviceaccount --namespace minio-tenant issuer -o json | jq -r ".secrets[].name")"

cat <<EOF | kubectl apply --filename -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: vault-issuer
  namespace: minio-tenant
spec:
  vault:
    server: http://vault.example.com
    path: pki/sign/example-dot-com
    auth:
      kubernetes:
        mountPath: /v1/auth/kubernetes
        role: issuer
        secretRef:
          name: ${ISSUER_SECRET_REF}
          key: token
EOF
