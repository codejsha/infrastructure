#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

cat <<EOF > ${DOMAIN_HOME}/scripts/regen-demo-identity.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

JAVA_HOME="${JAVA_HOME}"
WL_HOME="${WL_HOME}"
DOMAIN_HOME="${DOMAIN_HOME}"

cd \${DOMAIN_HOME}/security
. \${WL_HOME}/server/bin/setWLSEnv.sh
\${JAVA_HOME}/bin/java utils.CertGen -keyfilepass DemoIdentityPassPhrase -certfile democert -keyfile demokey -strength 2048 -noskid
\${JAVA_HOME}/bin/java utils.ImportPrivateKey -keystore DemoIdentity.jks -storepass DemoIdentityKeyStorePassPhrase -keyfile demokey.pem -keyfilepass DemoIdentityPassPhrase -certfile democert.pem -alias demoidentity
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/regen-demo-identity.sh
