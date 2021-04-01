#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

export JAVA_HOME="/usr/lib/jvm/java-11"
export CATALINA_HOME="/usr/local/tomcat"

######################################################################

export JAVA_VERSION="$(${JAVA_HOME}/bin/java -version 2>&1 /dev/null \
    | grep version | awk '{print $3}' | tr -d '"')"
