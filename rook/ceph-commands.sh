######################################################################

### health check

### pod running
kubectl get pods --namespace rook-ceph
kubectl get cephcluster --namespace rook-ceph

kubectl exec -it --namespace rook-ceph $(kubectl get pods --namespace rook-ceph --selector "app=rook-ceph-tools" --output jsonpath='{.items[0].metadata.name}') -- bash
ceph status
ceph osd status
ceph osd df
ceph osd utilization
ceph osd pool stats
ceph osd tree
ceph pg stat
ceph quorum_status
ceph mon stat
