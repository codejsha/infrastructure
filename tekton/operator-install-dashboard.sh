#!/usr/bin/bash
# https://github.com/tektoncd/operator

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace="${NAMESPACE}"

kubectl create clusterrolebinding tekton-operator-cluster-admin --clusterrole cluster-admin --serviceaccount tekton-operator:tekton-operator

cat <<EOF > ./operator-tekton-dashboard.yaml
apiVersion: operator.tekton.dev/v1alpha1
kind: TektonAddon
metadata:
  name: dashboard
spec:
  version: v0.8.2
EOF

kubectl apply -f operator-tekton-dashboard.yaml

# kubectl get tektonaddon dashboard -o jsonpath='{.status.conditions[0]}'
