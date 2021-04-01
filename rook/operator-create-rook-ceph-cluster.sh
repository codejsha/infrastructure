#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

/bin/cp -f cluster.yaml rook/cluster/examples/kubernetes/ceph/cluster.yaml

kubectl apply --filename rook/cluster/examples/kubernetes/ceph/cluster.yaml
kubectl apply --filename rook/cluster/examples/kubernetes/ceph/toolbox.yaml
# kubectl apply --filename rook/cluster/examples/kubernetes/ceph/dashboard-ingress-https.yaml
# kubectl apply --filename rook/cluster/examples/kubernetes/ceph/dashboard-loadbalancer.yaml
kubectl apply --filename dashboard-ingress.yaml
kubectl apply --filename rook/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml

### get dashboard password
# kubectl get secret rook-ceph-dashboard-password --namespace rook-ceph --output jsonpath="{['data']['password']}" | base64 --decode && echo

### health check
# kubectl get pods --namespace rook-ceph
# kubectl get cephcluster --namespace rook-ceph
# kubectl exec -it --namespace rook-ceph $(kubectl get pods --namespace rook-ceph --selector "app=rook-ceph-tools" --output jsonpath='{.items[0].metadata.name}') bash
### > ceph status
### > ceph osd status
### > ceph osd df
### > ceph osd utilization
### > ceph osd pool stats
### > ceph osd tree
### > ceph pg stat
### > ceph quorum_status
### > ceph mon stat
