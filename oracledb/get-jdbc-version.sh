#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

JAVA_HOME="/usr/lib/jvm/java-11"
JDBC_DRIVER_FILE="./ojdbc.jar"

######################################################################

${JAVA_HOME}/bin/java -jar ${JDBC_DRIVER_FILE} -getversion

# unzip -p ${JDBC_DRIVER_FILE} META-INF/MANIFEST.MF
