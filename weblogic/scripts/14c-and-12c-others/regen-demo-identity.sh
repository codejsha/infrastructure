#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

JAVA_HOME="/usr/java/current"
WL_HOME="/usr/local/weblogic/wlserver"
DOMAIN_HOME="/usr/local/weblogic/user_projects/domains/base_domain"

cd ${DOMAIN_HOME}/security
. ${WL_HOME}/server/bin/setWLSEnv.sh
${JAVA_HOME}/bin/java utils.CertGen -keyfilepass DemoIdentityPassPhrase -certfile democert -keyfile demokey -strength 2048 -noskid
${JAVA_HOME}/bin/java utils.ImportPrivateKey -keystore DemoIdentity.jks -storepass DemoIdentityKeyStorePassPhrase -keyfile demokey.pem -keyfilepass DemoIdentityPassPhrase -certfile democert.pem -alias demoidentity
