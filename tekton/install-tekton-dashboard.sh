#!/usr/bin/bash

kubectl apply --filename https://github.com/tektoncd/dashboard/releases/latest/download/tekton-dashboard-release.yaml
# TEKTON_DASHBOARD_VERSION="0.8.0"
# kubectl apply --filename https://github.com/tektoncd/dashboard/releases/download/v${TEKTON_DASHBOARD_VERSION}/tekton-dashboard-release.yaml

cat > tekton-dashboard-ingress.yaml <<EOF
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: tekton-dashboard
  namespace: tekton-pipelines
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: tekton.kube.example.com
    http:
      paths:
      - path: /
        backend:
          serviceName: tekton-dashboard
          servicePort: 9097
EOF

kubectl apply --filename tekton-dashboard-ingress.yaml
