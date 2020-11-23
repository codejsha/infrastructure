#!/bin/bash

source ./env-base.sh

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

cat << EOF > ${DOMAIN_HOME}/scripts/regen-demo-identity.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

WEBLOGIC_HOME="${WEBLOGIC_HOME}"
DOMAIN_HOME="${DOMAIN_HOME}"

cd \${DOMAIN_HOME}/security
. \${WEBLOGIC_HOME}/server/bin/setWLSEnv.sh
java utils.CertGen -keyfilepass DemoIdentityPassPhrase -certfile democert -keyfile demokey -strength 2048 -noskid
java utils.ImportPrivateKey -keystore DemoIdentity.jks -storepass DemoIdentityKeyStorePassPhrase -keyfile demokey.pem -keyfilepass DemoIdentityPassPhrase -certfile democert.pem -alias demoidentity
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/regen-demo-identity.sh
