#!/bin/bash

source ./env-base.sh

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

### replace pattern with string
TEMP="\${MW_HOME}"
VAR_DOMAIN_HOME_11="${DOMAIN_HOME/${MW_HOME}/${TEMP}}"
TEMP="\${DOMAIN_NAME}"
VAR_DOMAIN_HOME_11="${VAR_DOMAIN_HOME_11/${DOMAIN_NAME}/${TEMP}}"
TEMP="\${ORACLE_HOME}"
VAR_DOMAIN_HOME="${DOMAIN_HOME/${ORACLE_HOME}/${TEMP}}"
TEMP="\${DOMAIN_NAME}"
VAR_DOMAIN_HOME="${VAR_DOMAIN_HOME/${DOMAIN_NAME}/${TEMP}}"
TEMP="\${DOMAIN_HOME}"
VAR_LOG_DIR="${LOG_DIR/${DOMAIN_HOME}/${TEMP}}"

######################################################################

cat <<EOF > ${DOMAIN_HOME}/scripts/change_store_user_config.py
#!/usr/bin/env python

domain_home = os.environ['DOMAIN_HOME']
admin_server_url = os.environ['ADMIN_SERVER_URL']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

######################################################################

connect(admin_username, admin_password, admin_server_url)

storeUserConfig(domain_home + '/security/WebLogicConfig.properties',
                domain_home + '/security/WebLogicKey.properties')

exit()
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/scripts/change-store-user-config.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

EOF

if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/scripts/change-store-user-config.sh
MW_HOME="${MW_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
export DOMAIN_HOME="${VAR_DOMAIN_HOME_11}"
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/scripts/change-store-user-config.sh
ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
export DOMAIN_HOME="${VAR_DOMAIN_HOME}"
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/scripts/change-store-user-config.sh
export ADMIN_SERVER_URL="t3://${ADMIN_SERVER_LISTEN_ADDRESS}:${ADMIN_SERVER_LISTEN_PORT}"
export ADMIN_USERNAME="\${1:-"weblogic"}"
export ADMIN_PASSWORD="\${2:-"welcome1"}"

EOF

if [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/scripts/change-store-user-config.sh
\${MW_HOME}/wlserver_10.3/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/change_store_user_config.py
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^12.|^14.1 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/scripts/change-store-user-config.sh
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \${DOMAIN_HOME}/scripts/change_store_user_config.py
EOF
fi

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/change-store-user-config.sh
