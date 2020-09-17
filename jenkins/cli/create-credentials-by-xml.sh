#!/usr/bin/bash

source ./env.sh

CREDENTIAL_DOMAIN="cicd"
CREDENTIAL_USERNAME="username"
CREDENTIAL_PASSWORD="${PASSWORD}"
CREDENTIAL_DESCRIPTION=""

CREDENTIAL_UUID=$(uuidgen)
echo "UUID: ${CREDENTIAL_UUID}"

cat <<EOF > ./credentials.xml
<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl plugin="credentials@2.3.12">
    <scope>GLOBAL</scope>
    <id>${CREDENTIAL_UUID}</id>
    <description>${CREDENTIAL_DESCRIPTION}</description>
    <username>${CREDENTIAL_USERNAME}</username>
    <password>${CREDENTIAL_PASSWORD}</password>
</com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
EOF

${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    create-credentials-by-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIAL_DOMAIN}" < credentials.xml
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     create-credentials-by-xml "system::system::jenkins" "${CREDENTIAL_DOMAIN}" < credentials.xml

### get-credentials-as-xml
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     get-credentials-as-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIAL_DOMAIN}" "${CREDENTIAL_UUID}"
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     get-credentials-as-xml "system::system::jenkins" "${CREDENTIAL_DOMAIN}" "${CREDENTIAL_UUID}"
