#!/bin/bash

source ./env-base.sh
source ./env-job.sh

JENKINS_JOB_NAME="${1:-${JENKINS_JOB_NAME}}"

######################################################################

function build_job {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        build ${JENKINS_JOB_NAME}
}

function build_job_follow {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        build ${JENKINS_JOB_NAME} -f -v
}

function build_job_follow_foreground {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        build ${JENKINS_JOB_NAME} -s -v
}

######################################################################

# build_job
build_job_follow
# build_job_follow_foreground
