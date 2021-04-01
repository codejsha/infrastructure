#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

CLASSPATH=${CATALINA_HOME}/log4j2/lib/*:${CATALINA_HOME}/log4j2/conf
export CLASSPATH
