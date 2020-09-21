#!/usr/bin/bash

NAMESPACE="tekton-pipelines"
kubectl create namespace ${NAMESPACE}
kubectl config set-context --current --namespace="${NAMESPACE}"

kubectl apply --filename https://github.com/tektoncd/dashboard/releases/latest/tekton-dashboard-release.yaml
# TEKTON_DASHBOARD_VERSION="0.9.0"
# kubectl apply --filename https://github.com/tektoncd/dashboard/releases/download/v${TEKTON_DASHBOARD_VERSION}/tekton-dashboard-release.yaml

cat <<EOF > ./tekton-dashboard-ingress.yaml
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: tekton-dashboard
  annotations:
    kubernetes.io/ingress.class: "nginx"
  namespace: tekton-pipelines
spec:
  rules:
  - host: tekton.example.com
    http:
      paths:
      - path: /
        backend:
          serviceName: tekton-dashboard
          servicePort: 9097
EOF

kubectl apply --filename tekton-dashboard-ingress.yaml
