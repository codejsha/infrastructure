#!/bin/bash

source ./env-base.sh

######################################################################

function list_credentials {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        list-credentials "SystemCredentialsProvider::SystemContextResolver::jenkins"
}

######################################################################

list_credentials
