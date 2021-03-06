#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

GET_DATE="$(date +'%Y%m%d-%H%M%S')"
FILENAME="etcd-snapshot-${GET_DATE}"

export ETCDCTL_API=3
/usr/local/bin/etcdctl \
    --endpoints=https://controlplane1:2379 \
    --cacert=/etc/ssl/etcd/ssl/ca.pem \
    --cert=/etc/ssl/etcd/ssl/member-controlplane1.pem \
    --key=/etc/ssl/etcd/ssl/member-controlplane1-key.pem \
    snapshot save ${FILENAME}
