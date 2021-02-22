#!/bin/bash

### operator
docker image pull confluentinc/cp-operator-service:0.419.10
docker image tag confluentinc/cp-operator-service:0.419.10 core.harbor.example.com/confluentinc/cp-operator-service:0.419.10
docker image push core.harbor.example.com/confluentinc/cp-operator-service:0.419.10

### init container
docker image pull confluentinc/cp-init-container-operator:6.1.0.0
docker image tag confluentinc/cp-init-container-operator:6.1.0.0 core.harbor.example.com/confluentinc/cp-init-container-operator:6.1.0.0
docker image push core.harbor.example.com/confluentinc/cp-init-container-operator:6.1.0.0

### zookeeper
docker image pull confluentinc/cp-zookeeper-operator:6.1.0.0
docker image tag confluentinc/cp-zookeeper-operator:6.1.0.0 core.harbor.example.com/confluentinc/cp-zookeeper-operator:6.1.0.0
docker image push core.harbor.example.com/confluentinc/cp-zookeeper-operator:6.1.0.0

### kafka
docker image pull confluentinc/cp-server-operator:6.1.0.0
docker image tag confluentinc/cp-server-operator:6.1.0.0 core.harbor.example.com/confluentinc/cp-server-operator:6.1.0.0
docker image push core.harbor.example.com/confluentinc/cp-server-operator:6.1.0.0

### kafka-connect
docker image pull confluentinc/cp-server-connect-operator:6.1.0.0
docker image tag confluentinc/cp-server-connect-operator:6.1.0.0 core.harbor.example.com/confluentinc/cp-server-connect-operator:6.1.0.0
docker image push core.harbor.example.com/confluentinc/cp-server-connect-operator:6.1.0.0

### replicator
docker image pull confluentinc/cp-enterprise-replicator-operator:6.1.0.0
docker image tag confluentinc/cp-enterprise-replicator-operator:6.1.0.0 core.harbor.example.com/confluentinc/cp-enterprise-replicator-operator:6.1.0.0
docker image push core.harbor.example.com/confluentinc/cp-enterprise-replicator-operator:6.1.0.0

### schema-registry
docker image pull confluentinc/cp-schema-registry-operator:6.1.0.0
docker image tag confluentinc/cp-schema-registry-operator:6.1.0.0 core.harbor.example.com/confluentinc/cp-schema-registry-operator:6.1.0.0
docker image push core.harbor.example.com/confluentinc/cp-schema-registry-operator:6.1.0.0

### ksqldb
docker image pull confluentinc/cp-ksqldb-server-operator:6.1.0.0
docker image tag confluentinc/cp-ksqldb-server-operator:6.1.0.0 core.harbor.example.com/confluentinc/cp-ksqldb-server-operator:6.1.0.0
docker image push core.harbor.example.com/confluentinc/cp-ksqldb-server-operator:6.1.0.0

### control-center
docker image pull confluentinc/cp-enterprise-control-center-operator:6.1.0.0
docker image tag confluentinc/cp-enterprise-control-center-operator:6.1.0.0 core.harbor.example.com/confluentinc/cp-enterprise-control-center-operator:6.1.0.0
docker image push core.harbor.example.com/confluentinc/cp-enterprise-control-center-operator:6.1.0.0

### external-dns
# docker image pull registry.opensource.zalan.do/teapot/external-dns:v0.5.14
# docker image tag registry.opensource.zalan.do/teapot/external-dns:v0.5.14 core.harbor.example.com/confluentinc/teapot/external-dns:v0.5.14
# docker image push core.harbor.example.com/confluentinc/teapot/external-dns:v0.5.14
