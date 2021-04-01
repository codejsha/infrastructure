#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

JAVA_HOME="/usr/lib/jvm/java-11"
JRE_HOME="/usr/lib/jvm/jre-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
# JRE_HOME="/usr/lib/jvm/jre-1.8.0"
CATALINA_HOME="/usr/local/tomcat"

######################################################################

JAVA_VERSION="$(${JAVA_HOME}/bin/java -version 2>&1 /dev/null \
    | grep version | awk '{print $3}' | tr -d '"')"
