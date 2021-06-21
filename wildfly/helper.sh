#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

JBOSS_HOME="/usr/local/wildfly"

JAVA_HOME="/usr/lib/jvm/java-11"
# JAVA_HOME="/usr/lib/jvm/java-1.8.0"
# JAVA_HOME="/usr/lib/jvm/zulu11"
# JAVA_HOME="/usr/lib/jvm/zulu8"
# JAVA_HOME="/usr/java/current"

# BIND_ADDRESS="0.0.0.0"
# BIND_ADDRESS_MGMT="127.0.0.1"
# BIND_ADDRESS_PRIVATE="127.0.0.1"
BIND_ADDRESS="test.example.com"
BIND_ADDRESS_MGMT="test.example.com"
BIND_ADDRESS_PRIVATE="test.example.com"

INSTALL_SCRIPT_DIR="/svc/infrastructure/wildfly"

######################################################################

### escape forward slash
JAVA_HOME="${JAVA_HOME//\//\\/}"
JBOSS_HOME="${JBOSS_HOME//\//\\/}"
INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR//\//\\/}"

######################################################################

perl -pi -e "s/^JAVA_HOME=.*/JAVA_HOME=\"${JAVA_HOME}\"/" env-base.sh
perl -pi -e "s/^JBOSS_HOME=.*/JBOSS_HOME=\"${JBOSS_HOME}\"/" env-base.sh
perl -pi -e "s/^BIND_ADDRESS=.*/BIND_ADDRESS=\"${BIND_ADDRESS}\"/" env-base.sh
perl -pi -e "s/^BIND_ADDRESS_MGMT=.*/BIND_ADDRESS_MGMT=\"${BIND_ADDRESS_MGMT}\"/" env-base.sh
