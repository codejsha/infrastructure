#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

DATETIME="$(date +'%Y%m%d-%H%M%S')"
FILENAME="etcd-snapshot-${DATETIME}"

export ETCDCTL_API=3
sudo /usr/local/bin/etcdctl \
    --endpoints=https://controlplane1:2379 \
    --cacert=/etc/ssl/etcd/ssl/ca.pem \
    --cert=/etc/ssl/etcd/ssl/member-controlplane1.pem \
    --key=/etc/ssl/etcd/ssl/member-controlplane1-key.pem \
    snapshot save ${FILENAME}
