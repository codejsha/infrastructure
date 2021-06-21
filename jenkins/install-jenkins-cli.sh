#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ./env-base.sh

if [ ! -f "${JENKINS_FILE_DIR}/jenkins-cli.jar" ]; then
    mkdir -p ${JENKINS_FILE_DIR}
    curl -o ${JENKINS_FILE_DIR}/jenkins-cli.jar -LJO ${JENKINS_URL}/jnlpJars/jenkins-cli.jar
fi
