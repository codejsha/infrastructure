#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

INSTANCE_NAME="inst1"
export JAVA_HOME="/usr/lib/jvm/java-11"
export JBOSS_HOME="/usr/local/jboss"
export JBOSS_BASE_DIR="${JBOSS_HOME}/instances/inst1"
export JBOSS_CONFIG_DIR="${JBOSS_BASE_DIR}/configuration"
SERVER_CONFIG_FILE="standalone-ha.xml"

BIND_ADDRESS_MGMT="test.example.com"
JBOSS_MGMT_HTTP_PORT="9990"

${JBOSS_HOME}/bin/jboss-cli.sh \
    --connect \
    --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
    --command=":shutdown"
