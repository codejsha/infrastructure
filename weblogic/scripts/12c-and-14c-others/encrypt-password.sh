#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

JAVA_HOME="/usr/java/current"
WL_HOME="/usr/local/weblogic/wlserver"
PLAINTEXT_PASSWORD="${1}"

ENCRYPTED_PASSWORD=$(${JAVA_HOME}/bin/java -classpath ${WL_HOME}/server/lib/weblogic.jar weblogic.security.Encrypt ${PLAINTEXT_PASSWORD})
echo ${ENCRYPTED_PASSWORD}
