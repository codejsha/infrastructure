#!/bin/bash

source ./env-base.sh
source ./env-credentials.sh

CREDENTIALS_DOMAIN="${CREDENTIALS_DOMAIN}"
CREDENTIALS_USERNAME="${USERNAME}"
CREDENTIALS_PASSWORD="${PASSWORD}"
CREDENTIALS_DESCRIPTION="${CREDENTIALS_DESCRIPTION}"
CREDENTIALS_UUID=$(uuidgen)

echo "UUID: ${CREDENTIALS_UUID}"

######################################################################

if [ ! -f "credentials.xml" ]; then
cat <<EOF > ./credentials.xml
<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl plugin="credentials@2.3.12">
    <scope>GLOBAL</scope>
    <id>${CREDENTIALS_UUID}</id>
    <description>${CREDENTIALS_DESCRIPTION}</description>
    <username>${CREDENTIALS_USERNAME}</username>
    <password>${CREDENTIALS_PASSWORD}</password>
</com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
EOF
fi

######################################################################

function create_credentials_with_xml {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        create-credentials-with-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIALS_DOMAIN}" < credentials.xml
    # ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
    #    -s ${JENKINS_URL} \
    #    -webSocket \
    #    -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    #     create-credentials-with-xml "system::system::jenkins" "${CREDENTIALS_DOMAIN}" < credentials.xml
}

######################################################################

create_credentials_with_xml
