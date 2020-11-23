#!/bin/bash

export ETCDCTL_API=3
/usr/local/bin/etcdctl \
    --endpoints=https://10.10.10.11:2379,https://10.10.10.12:2379,https://10.10.10.13:2379 \
    --cacert=/etc/ssl/etcd/ssl/ca.pem \
    --cert=/etc/ssl/etcd/ssl/member-controlplane1.pem \
    --key=/etc/ssl/etcd/ssl/member-controlplane1-key.pem \
    endpoint health
