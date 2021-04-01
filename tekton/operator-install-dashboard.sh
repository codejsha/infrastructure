#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace "${NAMESPACE}"

kubectl create clusterrolebinding tekton-operator-cluster-admin --clusterrole cluster-admin --serviceaccount tekton-operator:tekton-operator

cat <<EOF > ./operator-tekton-dashboard.yaml
apiVersion: operator.tekton.dev/v1alpha1
kind: TektonAddon
metadata:
  name: dashboard
spec:
  version: v0.8.2
EOF

kubectl apply --filename operator-tekton-dashboard.yaml

### check
# kubectl get tektonaddon dashboard --output jsonpath='{.status.conditions[0]}'
