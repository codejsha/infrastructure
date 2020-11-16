#!/usr/bin/bash
# https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy

PASSWORD="${PASSWORD}"

NAMESPACE="mssql-system"

# helm install my-mssql \
helm upgrade --install my-mssql \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set acceptEula.value="Y" \
    --set edition.value="Developer" \
    --set collation="SQL_Latin1_General_100_CI_AS_SC" \
    --set sapassword="${PASSWORD}" \
    --set persistence.enabled="true" \
    --set persistence.storageClass="rook-ceph-block" \
    --set service.type="LoadBalancer" \
    --set service.loadBalancerIP="10.10.10.98" \
    --version 0.11.2 \
    stable/mssql-linux
