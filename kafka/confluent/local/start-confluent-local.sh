#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

confluent local services zookeeper start
confluent local services kafka start --config kafka.properties
confluent local services schema-registry start
confluent local services connect start
confluent local services kafka-rest start
confluent local services ksql-server start
confluent local services control-center start
