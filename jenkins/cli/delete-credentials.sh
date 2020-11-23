#!/bin/bash

source ./env.sh

CREDENTIAL_DOMAIN="${${CREDENTIAL_DOMAIN}:-cicd}"
CREDENTIAL_UUID="${1:-${CREDENTIAL_UUID}}"

${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    delete-credentials "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIAL_DOMAIN}" ${CREDENTIAL_UUID}
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     delete-credentials "system::system::jenkins" "${CREDENTIAL_DOMAIN}" ${CREDENTIAL_UUID}
