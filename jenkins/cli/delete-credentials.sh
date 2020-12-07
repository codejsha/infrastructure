#!/bin/bash

source ./env-base.sh

CREDENTIALS_DOMAIN="${1}"
CREDENTIALS_UUID="${2}"

######################################################################

function delete_credentials {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        delete-credentials "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIALS_DOMAIN}" ${CREDENTIALS_UUID}
    # ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
    #    -s ${JENKINS_URL} \
    #    -webSocket \
    #    -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    #     delete-credentials "system::system::jenkins" "${CREDENTIALS_DOMAIN}" ${CREDENTIALS_UUID}
}

######################################################################

delete_credentials_domain
