#!/bin/bash

source ./env-base.sh

MANAGED_SERVER_NAME="${1}"

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

### transform variables
TEMP="\${MW_HOME}"
VAR_DOMAIN_HOME_11="${DOMAIN_HOME/${MW_HOME}/${TEMP}}"
TEMP="\${ORACLE_HOME}"
VAR_DOMAIN_HOME="${DOMAIN_HOME/${ORACLE_HOME}/${TEMP}}"

######################################################################

cat << EOF > ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.py
#!/usr/bin/env python

domain_home = os.environ['DOMAIN_HOME']
admin_server_url = os.environ['ADMIN_SERVER_URL']
managed_server_name = os.environ['MANAGED_SERVER_NAME']

######################################################################

connect(userConfigFile=domain_home + '/security/WebLogicConfig.properties',
        userKeyFile=domain_home + '/security/WebLogicKey.properties',
        url=admin_server_url)

shutdown(managed_server_name, 'Server', ignoreSessions='true', force='true')

exit()
EOF

######################################################################

if [ "${MAJOR_VERSION}" == "11g" ]; then
cat << EOF > ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

MW_HOME="${MW_HOME}"
export DOMAIN_HOME="${VAR_DOMAIN_HOME_11}"
EOF
elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
cat << EOF > ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh
#!/bin/bash

ORACLE_HOME="${ORACLE_HOME}"
export DOMAIN_HOME="${VAR_DOMAIN_HOME}"
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh
export ADMIN_SERVER_URL="t3://${ADMIN_SERVER_LISTEN_ADDRESS}:${ADMIN_SERVER_LISTEN_PORT}"
export MANAGED_SERVER_NAME="${MANAGED_SERVER_NAME}"
EOF

if [ "${MAJOR_VERSION}" == "11g" ]; then
cat << EOF >> ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh

${MW_HOME}/wlserver_10.3/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.py
EOF
elif [ "${MAJOR_VERSION}" == "12c" ] || [ "${MAJOR_VERSION}" == "14c" ]; then
cat << EOF >> ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh

${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.py
EOF
fi

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh
