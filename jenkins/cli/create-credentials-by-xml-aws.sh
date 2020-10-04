#!/usr/bin/bash

source ./env.sh

CREDENTIAL_DOMAIN="${${CREDENTIAL_DOMAIN}:-cicd}"
CREDENTIAL_ACCESSKEY="${1:-accesskey}"
CREDENTIAL_SECRETKEY="${2:-secretkey}"
CREDENTIAL_DESCRIPTION="${CREDENTIAL_DESCRIPTION}"

CREDENTIAL_UUID="$(uuidgen)"
echo "UUID: ${CREDENTIAL_UUID}"

cat <<EOF > ./credentials-aws.xml
<com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl plugin="aws-credentials@1.28">
    <scope>GLOBAL</scope>
    <id>${CREDENTIAL_UUID}</id>
    <description>${CREDENTIAL_DESCRIPTION}</description>
    <accessKey>${CREDENTIAL_ACCESSKEY}</accessKey>
    <secretKey>${CREDENTIAL_SECRETKEY}</secretKey>
    <iamRoleArn></iamRoleArn>
    <iamMfaSerialNumber></iamMfaSerialNumber>
</com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl>
EOF
}

${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    create-credentials-by-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIAL_DOMAIN}" < credentials-aws.xml
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     create-credentials-by-xml "system::system::jenkins" "${CREDENTIAL_DOMAIN}" < credentials-aws.xml

rm credentials-aws.xml

### get-credentials-as-xml
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     get-credentials-as-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIAL_DOMAIN}" "${CREDENTIAL_UUID}"
# ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar -s ${JENKINS_URL} -webSocket -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
#     get-credentials-as-xml "system::system::jenkins" "${CREDENTIAL_DOMAIN}" "${CREDENTIAL_UUID}"
