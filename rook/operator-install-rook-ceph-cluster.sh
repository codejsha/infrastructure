#!/bin/bash
# https://rook.github.io/docs/rook/v1.4/ceph-quickstart.html
# https://rook.github.io/docs/rook/v1.4/ceph-block.html
# https://rook.github.io/docs/rook/v1.4/ceph-csi-drivers.html
# https://rook.github.io/docs/rook/v1.4/ceph-dashboard.html

/usr/bin/cp -f cluster.yaml rook/cluster/examples/kubernetes/ceph/cluster.yaml
kubectl create -f rook/cluster/examples/kubernetes/ceph/cluster.yaml
kubectl create -f rook/cluster/examples/kubernetes/ceph/toolbox.yaml
# kubectl create -f rook/cluster/examples/kubernetes/ceph/dashboard-ingress-https.yaml
# kubectl create -f rook/cluster/examples/kubernetes/ceph/dashboard-loadbalancer.yaml
kubectl apply -f dashboard-ingress.yaml
kubectl create -f rook/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml

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
