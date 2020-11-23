#!/bin/bash

# kubectl annotate --overwrite storageclass standard storageclass.kubernetes.io/is-default-class=true
# kubectl annotate --overwrite storageclass standard storageclass.kubernetes.io/is-default-class=false

kubectl annotate --overwrite storageclass rook-ceph-block storageclass.kubernetes.io/is-default-class=true
# kubectl annotate --overwrite storageclass rook-ceph-block storageclass.kubernetes.io/is-default-class=false

# kubectl get storageclass
