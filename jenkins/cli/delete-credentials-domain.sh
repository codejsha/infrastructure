#!/bin/bash

source ./env.sh

CREDENTIAL_DOMAIN="${${CREDENTIAL_DOMAIN}:-cicd}"

${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    delete-credentials-domain "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIAL_DOMAIN}"
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     delete-credentials-domain "system::system::jenkins" "${CREDENTIAL_DOMAIN}"
