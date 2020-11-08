#!/usr/bin/bash

source ./env.sh

CREDENTIAL_DOMAIN="cicd"

cat <<EOF > ./credentials-domain.xml
<com.cloudbees.plugins.credentials.domains.Domain plugin="credentials@2.3.12">
    <name>${CREDENTIAL_DOMAIN}</name>
    <specifications/>
</com.cloudbees.plugins.credentials.domains.Domain>
EOF

${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    create-credentials-domain-with-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" < credentials-domain.xml
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     create-credentials-domain-with-xml "system::system::jenkins" < credentials-domain.xml

### get-credentials-domain-as-xml
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     get-credentials-domain-as-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIAL_DOMAIN}"
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     get-credentials-domain-as-xml "system::system::jenkins" "${CREDENTIAL_DOMAIN}"
