#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

cat <<EOF > ${DOMAIN_HOME}/scripts/regen-demo-identity.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

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
