#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ./env-base.sh

CREDENTIALS_DOMAIN="${1}"
CREDENTIALS_UUID="${2}"

######################################################################

function delete_credentials {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        --silent ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        delete-credentials "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIALS_DOMAIN}" ${CREDENTIALS_UUID}
    # ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
    #    --silent ${JENKINS_URL} \
    #    -webSocket \
    #    -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    #     delete-credentials "system::system::jenkins" "${CREDENTIALS_DOMAIN}" ${CREDENTIALS_UUID}
}

######################################################################

delete_credentials_domain
