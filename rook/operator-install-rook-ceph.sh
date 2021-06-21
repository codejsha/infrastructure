#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

git clone --single-branch --branch release-1.6 https://github.com/rook/rook.git

# curl -LJO https://github.com/rook/rook/archive/refs/tags/v1.6.2.tar.gz
# tar -xzf rook-1.6.2.tar.gz
# mv rook-1.6.2 rook

kubectl apply --filename rook/cluster/examples/kubernetes/ceph/crds.yaml
kubectl apply --filename rook/cluster/examples/kubernetes/ceph/common.yaml
kubectl apply --filename rook/cluster/examples/kubernetes/ceph/operator.yaml

### verify the rook-ceph-operator is in the `Running` state before proceeding
kubectl get pods --namespace rook-ceph --watch
### NAME                                  READY   STATUS    RESTARTS   AGE
### rook-ceph-operator-667756ddb6-spzpt   1/1     Running   0          2m9s
### rook-discover-54vcm                   1/1     Running   0          83s
### rook-discover-tfsl4                   1/1     Running   0          83s
### rook-discover-v26jr                   1/1     Running   0          83s

### delete
# kubectl delete --filename rook/cluster/examples/kubernetes/ceph/operator.yaml
# kubectl delete --filename rook/cluster/examples/kubernetes/ceph/common.yaml
# kubectl delete --filename rook/cluster/examples/kubernetes/ceph/crds.yaml
