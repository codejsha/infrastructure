#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

CATALINA_HOME="/usr/local/tomcat"

JAVA_HOME="/usr/lib/jvm/java-11"
JRE_HOME="/usr/lib/jvm/jre-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
# JRE_HOME="/usr/lib/jvm/jre-1.8.0"

######################################################################

### escape forward slash
JAVA_HOME="${JAVA_HOME//\//\\/}"
JRE_HOME="${JRE_HOME//\//\\/}"
CATALINA_HOME="${CATALINA_HOME//\//\\/}"

######################################################################

perl -pi -e "s/JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/" env-base.sh
perl -pi -e "s/JRE_HOME=.*/JRE_HOME=\"${JRE_HOME}\"/" env-base.sh
perl -pi -e "s/CATALINA_HOME=.*/CATALINA_HOME=\"${CATALINA_HOME}\"/" env-base.sh
