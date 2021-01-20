#!/bin/bash

INSTANCE_NAME="inst1"   # default
PORT_OFFSET="0"         # default
source ./env-function.sh

JAVA_HOME="/usr/lib/jvm/java-11"
JBOSS_HOME="/usr/local/wildfly"
JBOSS_BASE_DIR="${JBOSS_HOME}/instances/${INSTANCE_NAME}"
JBOSS_CONFIG_DIR="${JBOSS_BASE_DIR}/configuration"

# SERVER_CONFIG_FILE="standalone-full-ha.xml"
# SERVER_CONFIG_FILE="standalone-full.xml"
SERVER_CONFIG_FILE="standalone-ha.xml"
# SERVER_CONFIG_FILE="standalone.xml"

BIND_ADDRESS="0.0.0.0"
BIND_ADDRESS_MGMT="127.0.0.1"
BIND_ADDRESS_PRIVATE="127.0.0.1"
DEFAULT_MULTICAST_ADDRESS="230.0.0.4"

JBOSS_HTTP_PORT="8080"
JBOSS_HTTPS_PORT="8443"
JBOSS_AJP_PORT="8009"
JBOSS_MGMT_HTTP_PORT="9990"
JBOSS_MGMT_HTTPS_PORT="9993"

JBOSS_LOG_DIR="${JBOSS_BASE_DIR}/logs"

######################################################################

JAVA_VERSION="$(${JAVA_HOME}/bin/java -version 2>&1 /dev/null \
    | grep version | awk '{print $3}' | tr -d '"')"

JBOSS_HTTP_PORT="$(( ${JBOSS_HTTP_PORT} + ${PORT_OFFSET} ))"
JBOSS_HTTPS_PORT="$(( ${JBOSS_HTTPS_PORT} + ${PORT_OFFSET} ))"
JBOSS_AJP_PORT="$(( ${JBOSS_AJP_PORT} + ${PORT_OFFSET} ))"
JBOSS_MGMT_HTTP_PORT="$(( ${JBOSS_MGMT_HTTP_PORT} + ${PORT_OFFSET} ))"
JBOSS_MGMT_HTTPS_PORT="$(( ${JBOSS_MGMT_HTTPS_PORT} + ${PORT_OFFSET} ))"
