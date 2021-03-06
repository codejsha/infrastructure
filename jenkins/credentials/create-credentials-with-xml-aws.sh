#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh
source ./env-credentials.sh

CREDENTIALS_DOMAIN="${CREDENTIALS_DOMAIN}"
CREDENTIALS_ACCESSKEY="${CREDENTIALS_ACCESSKEY}"
CREDENTIALS_SECRETKEY="${CREDENTIALS_SECRETKEY}"
CREDENTIALS_DESCRIPTION="${CREDENTIALS_DESCRIPTION}"
CREDENTIALS_UUID="$(uuidgen)"

echo "UUID: ${CREDENTIALS_UUID}"

######################################################################

if [ ! -f "credentials-aws.xml" ]; then
cat <<EOF > ./credentials-aws.xml
<com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl plugin="aws-credentials@1.28">
    <scope>GLOBAL</scope>
    <id>${CREDENTIALS_UUID}</id>
    <description>${CREDENTIALS_DESCRIPTION}</description>
    <accessKey>${CREDENTIALS_ACCESSKEY}</accessKey>
    <secretKey>${CREDENTIALS_SECRETKEY}</secretKey>
    <iamRoleArn></iamRoleArn>
    <iamMfaSerialNumber></iamMfaSerialNumber>
</com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl>
EOF
fi

######################################################################

function create_credentials_with_xml_aws {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        create-credentials-with-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "${CREDENTIALS_DOMAIN}" < credentials-aws.xml
    # ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
    #     -s ${JENKINS_URL} \
    #     -webSocket \
    #     -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    #     create-credentials-with-xml "system::system::jenkins" "${CREDENTIALS_DOMAIN}" < credentials-aws.xml
}

######################################################################

create_credentials_with_xml_aws
# rm -f ./credentials-aws.xml
