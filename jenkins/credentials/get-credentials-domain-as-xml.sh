#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh
source ./env-credentials.sh

CREDENTIALS_DOMAIN="${CREDENTIALS_DOMAIN}"

######################################################################

function get_credentials_domain_as_xml {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        --silent ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        get-credentials-domain-as-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIAL_DOMAIN}"
    # ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
    #     --silent ${JENKINS_URL} \
    #     -webSocket \
    #     -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    #     get-credentials-domain-as-xml "system::system::jenkins" "${CREDENTIAL_DOMAIN}"
}

######################################################################

get_credentials_domain_as_xml
