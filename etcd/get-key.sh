#!/bin/bash

KEYWORD="${1}"

export ETCDCTL_API=3
/usr/local/bin/etcdctl \
    --endpoints=https://controlplane1:2379,https://controlplane2:2379,https://controlplane3:2379 \
    --cacert=/etc/ssl/etcd/ssl/ca.pem \
    --cert=/etc/ssl/etcd/ssl/member-controlplane1.pem \
    --key=/etc/ssl/etcd/ssl/member-controlplane1-key.pem \
    get / --prefix --keys-only \
    | grep ${KEYWORD}
