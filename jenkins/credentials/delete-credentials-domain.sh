#!/bin/bash

source ./env-base.sh
source ./env-credentials.sh

CREDENTIALS_DOMAIN="${1:-${CREDENTIALS_DOMAIN}}"

######################################################################

function delete_credentials_domain {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        delete-credentials-domain "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIALS_DOMAIN}"
    # ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
    #    -s ${JENKINS_URL} \
    #    -webSocket \
    #    -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    #     delete-credentials-domain "system::system::jenkins" "${CREDENTIALS_DOMAIN}"
}

######################################################################

delete_credentials_domain
