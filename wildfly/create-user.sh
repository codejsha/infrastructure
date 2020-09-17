#!/usr/bin/bash

source ./env-base.sh
source ./env-inst.sh

### management user
${WILDFLY_HOME}/bin/add-user.sh -u "admin" -p "${PASSWORD}" -sc ${INSTANCE_HOME}/configuration
# ${WILDFLY_HOME}/bin/add-user.sh -u "admin" -p "${PASSWORD}"

### application usser
# ${WILDFLY_HOME}/bin/add-user.sh -u "developer" -p "${PASSWORD}"
# ${WILDFLY_HOME}/bin/add-user.sh -u "developer" -p "${PASSWORD}" -sc ${INSTANCE_HOME}/configuration
