#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh
source ./env-job.sh

JENKINS_JOB_NAME="${1:-${JENKINS_JOB_NAME}}"
JENKINS_JOB_RANGE="${2:-${JENKINS_JOB_RANGE}}"

######################################################################

function delete_builds {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        --silent ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        delete-builds ${JENKINS_JOB_NAME} ${JENKINS_JOB_RANGE}
}

######################################################################

delete_builds
