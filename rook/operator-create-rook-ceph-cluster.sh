#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

/bin/cp -f cluster.yaml rook/cluster/examples/kubernetes/ceph/cluster.yaml

kubectl apply -f rook/cluster/examples/kubernetes/ceph/cluster.yaml
kubectl apply -f rook/cluster/examples/kubernetes/ceph/toolbox.yaml
# kubectl apply -f rook/cluster/examples/kubernetes/ceph/dashboard-ingress-https.yaml
# kubectl apply -f rook/cluster/examples/kubernetes/ceph/dashboard-loadbalancer.yaml
kubectl apply -f dashboard-ingress.yaml
kubectl apply -f rook/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml

### get dashboard password
# kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo

### health check
# kubectl -n rook-ceph get pod
# kubectl -n rook-ceph get cephcluster
# kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
### > ceph status
### > ceph osd status
### > ceph osd df
### > ceph osd utilization
### > ceph osd pool stats
### > ceph osd tree
### > ceph pg stat
### > ceph quorum_status
### > ceph mon stat
