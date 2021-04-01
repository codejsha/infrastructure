#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace "${NAMESPACE}"

cat <<EOF > ./operator-tekton-triggers.yaml
apiVersion: operator.tekton.dev/v1alpha1
kind: TektonAddon
metadata:
  name: trigger
spec:
  version: v0.7.0
EOF

kubectl apply --filename operator-tekton-triggers.yaml

### check
# tkn version
