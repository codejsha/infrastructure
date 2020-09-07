#!/usr/bin/bash

source ./env.sh
source ./env-job.sh

JENKINS_JOB_NAME="${1:-${JENKINS_JOB_NAME}}"

${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    build ${JENKINS_JOB_NAME} -f -v
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     build ${JENKINS_JOB_NAME} -s -v