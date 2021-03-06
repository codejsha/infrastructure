#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

JBOSS_HOME="${JBOSS_HOME}"

${JBOSS_HOME}/bin/standalone.sh -v
