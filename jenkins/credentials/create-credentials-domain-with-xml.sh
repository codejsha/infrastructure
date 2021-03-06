#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh
source ./env-credentials.sh

CREDENTIALS_DOMAIN="${CREDENTIALS_DOMAIN}"

######################################################################

if [ ! -f "credentials-domain.xml" ]; then
cat <<EOF > ./credentials-domain.xml
<com.cloudbees.plugins.credentials.domains.Domain plugin="credentials@2.3.12">
    <name>${CREDENTIALS_DOMAIN}</name>
    <specifications/>
</com.cloudbees.plugins.credentials.domains.Domain>
EOF
fi

######################################################################

function create_credentials_domain_with_xml {
    ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
        -s ${JENKINS_URL} \
        -webSocket \
        -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
        create-credentials-domain-with-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" < credentials-domain.xml
    # ${JAVA_HOME}/bin/java -jar ${JENKINS_FILE_DIR}/jenkins-cli.jar \
    #     -s ${JENKINS_URL} \
    #     -webSocket \
    #     -auth ${JENKINS_USER}:${JENKINS_API_TOKEN} \
    #     create-credentials-domain-with-xml "system::system::jenkins" < credentials-domain.xml
}

######################################################################

create_credentials_domain_with_xml
