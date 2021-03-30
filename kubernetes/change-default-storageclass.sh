#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

kubectl annotate --overwrite storageclass standard storageclass.kubernetes.io/is-default-class=true
# kubectl annotate --overwrite storageclass standard storageclass.kubernetes.io/is-default-class=false

# kubectl annotate --overwrite storageclass local-path storageclass.kubernetes.io/is-default-class=true
# kubectl annotate --overwrite storageclass local-path storageclass.kubernetes.io/is-default-class=false

# kubectl annotate --overwrite storageclass rook-ceph-block storageclass.kubernetes.io/is-default-class=true
# kubectl annotate --overwrite storageclass rook-ceph-block storageclass.kubernetes.io/is-default-class=false

# kubectl get storageclass
