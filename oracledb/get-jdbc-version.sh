#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

JAVA_HOME="/usr/lib/jvm/java-11"
JDBC_DRIVER_FILE="./ojdbc.jar"

######################################################################

${JAVA_HOME}/bin/java -jar ${JDBC_DRIVER_FILE} -getversion

# unzip -p ${JDBC_DRIVER_FILE} META-INF/MANIFEST.MF
