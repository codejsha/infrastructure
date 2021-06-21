#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

INSTANCE_NAME="inst1"
export JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JBOSS_HOME="/usr/local/jboss"
export JBOSS_BASE_DIR="${JBOSS_HOME}/instances/inst1"
export JBOSS_CONFIG_DIR="${JBOSS_BASE_DIR}/configuration"
SERVER_CONFIG_FILE="standalone-ha.xml"

BIND_ADDRESS_MGMT="test.example.com"
JBOSS_MGMT_HTTP_PORT="9990"
USERNAME="admin"
PASSWORD="welcome1"

${JBOSS_HOME}/bin/jboss-cli.sh \
    --connect \
    --controller="${BIND_ADDRESS_MGMT}:${JBOSS_MGMT_HTTP_PORT}" \
    --user="${USERNAME}" \
    --password="${PASSWORD}" \
    --command=":shutdown"
