#!/usr/bin/bash

PASSWORD="${PASSWORD}"

NAMESPACE="mysql-system"
kubectl create namespace ${NAMESPACE}

# helm install my-mysql \
helm upgrade --install my-mysql \
    --namespace ${NAMESPACE} \
    --set imageTag="8.0.21" \
    --set mysqlRootPassword="${PASSWORD}" \
    --set timezone="Asia/Seoul" \
    --set service.type="LoadBalancer" \
    --set service.loadBalancerIP="10.10.10.97" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --version 1.6.6 \
    stable/mysql

    ### mysql 5
    # --set imageTag: "5.7.31"

### get the root password
# MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace ${NAMESPACE} my-mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo)
### connect to the database directly from outside the cluster
### https://dev.mysql.com/doc/refman/8.0/en/connection-options.html
# mysql --host=${MYSQL_HOST} --port=${MYSQL_PORT} --user=root --password=${MYSQL_ROOT_PASSWORD}
