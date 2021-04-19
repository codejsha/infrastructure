#!/bin/bash
set -o xtrace
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"

JAVA_HOME="/usr/java/current"
WL_HOME="/usr/local/weblogic/wlserver_10.3"
PLAINTEXT_PASSWORD="${1}"

ENCRYPTED_PASSWORD="$(${JAVA_HOME}/bin/java -classpath ${WL_HOME}/server/lib/weblogic.jar weblogic.security.Encrypt ${PLAINTEXT_PASSWORD})"
echo ${ENCRYPTED_PASSWORD}
