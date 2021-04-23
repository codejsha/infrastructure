#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

/bin/cp -f cluster.yaml rook/cluster/examples/kubernetes/ceph/cluster.yaml

kubectl apply --filename rook/cluster/examples/kubernetes/ceph/cluster.yaml
kubectl apply --filename rook/cluster/examples/kubernetes/ceph/toolbox.yaml
kubectl apply --filename rook/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml

# kubectl apply --filename rook/cluster/examples/kubernetes/ceph/dashboard-ingress-https.yaml
# kubectl apply --filename rook/cluster/examples/kubernetes/ceph/dashboard-loadbalancer.yaml
kubectl apply --filename dashboard-ingress.yaml

### delete
# kubectl delete --filename dashboard-ingress.yaml
# kubectl delete --filename rook/cluster/examples/kubernetes/ceph/dashboard-loadbalancer.yaml
# kubectl delete --filename rook/cluster/examples/kubernetes/ceph/dashboard-ingress-https.yaml
# kubectl delete --filename rook/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml
# kubectl delete --filename rook/cluster/examples/kubernetes/ceph/toolbox.yaml
# kubectl delete --filename rook/cluster/examples/kubernetes/ceph/cluster.yaml
