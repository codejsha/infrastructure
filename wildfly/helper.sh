#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/java/current"
JBOSS_HOME="/usr/local/wildfly"
# BIND_ADDRESS="0.0.0.0"
# BIND_ADDRESS_MGMT="127.0.0.1"
BIND_ADDRESS="test.example.com"
BIND_ADDRESS_MGMT="test.example.com"

######################################################################

### escape forward slash
JAVA_HOME="${JAVA_HOME//\//\/}"
JBOSS_HOME="${JBOSS_HOME//\//\/}"

######################################################################

find . -type f -name "env-base.sh" | xargs perl -pi -e "s/^JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/^JBOSS_HOME=.*/JBOSS_HOME=\"${JBOSS_HOME}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/^BIND_ADDRESS=.*/BIND_ADDRESS=\"${BIND_ADDRESS}\"/"
find . -type f -name "env-base.sh" | xargs perl -pi -e "s/^BIND_ADDRESS_MGMT=.*/BIND_ADDRESS_MGMT=\"${BIND_ADDRESS_MGMT}\"/"
