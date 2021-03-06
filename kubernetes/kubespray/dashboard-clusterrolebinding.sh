#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

kubectl create clusterrolebinding kubernetes-dashboard-admin \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:kubernetes-dashboard

# cat <<EOF > ./dashboard-clusterrolebinding.yaml
# apiVersion: rbac.authorization.k8s.io/v1
# kind: ClusterRoleBinding
# metadata:
#   name: kubernetes-dashboard-admin
# roleRef:
#   apiGroup: rbac.authorization.k8s.io
#   kind: ClusterRole
#   name: cluster-admin
# subjects:
# - kind: ServiceAccount
#   name: kubernetes-dashboard
#   namespace: kube-system
# EOF
# kubectl apply --filename dashboard-clusterrolebinding.yaml
