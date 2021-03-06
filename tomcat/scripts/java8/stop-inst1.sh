#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

INSTANCE_NAME="inst1"
export JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JRE_HOME="/usr/lib/jvm/jre-1.8.0"
export CATALINA_HOME="/usr/local/tomcat"
export CATALINA_BASE="${CATALINA_HOME}/instances/${INSTANCE_NAME}"

${CATALINA_HOME}/bin/shutdown.sh
