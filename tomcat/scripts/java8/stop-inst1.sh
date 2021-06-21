#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

INSTANCE_NAME="inst1"
export JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JRE_HOME="/usr/lib/jvm/jre-1.8.0"
export CATALINA_HOME="/usr/local/tomcat"
export CATALINA_BASE="${CATALINA_HOME}/instances/${INSTANCE_NAME}"

${CATALINA_HOME}/bin/shutdown.sh
