#!/bin/bash

CONFLUENT_HOME=""

pssh \
    --hosts=${CONFLUENT_HOME}/pssh/hosts/zookeeper.hosts \
    --hosts=${CONFLUENT_HOME}/pssh/hosts/kafka.hosts \
    --hosts=${CONFLUENT_HOME}/pssh/hosts/schema-registry.hosts \
    --hosts=${CONFLUENT_HOME}/pssh/hosts/kafka-connect.hosts \
    --hosts=${CONFLUENT_HOME}/pssh/hosts/replicator.hosts \
    --hosts=${CONFLUENT_HOME}/pssh/hosts/kafka-rest.hosts \
    --hosts=${CONFLUENT_HOME}/pssh/hosts/ksqldb.hosts \
    --hosts=${CONFLUENT_HOME}/pssh/hosts/control-center.hosts \
    --askpass \
    --inline \
    "pkill -9 -ecx java"
