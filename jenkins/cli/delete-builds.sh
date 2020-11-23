#!/bin/bash

source ./env.sh
source ./env-job.sh

JENKINS_JOB_NAME="${1:-${JENKINS_JOB_NAME}}"
JENKINS_JOB_RANGE="${2:-${JENKINS_JOB_RANGE}}"

${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    delete-builds ${JENKINS_JOB_NAME} ${JENKINS_JOB_RANGE}
