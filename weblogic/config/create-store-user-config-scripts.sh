#!/usr/bin/bash

source ./env-base.sh

MANAGED_SERVER_NAME="${1}"

######################################################################

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

cat << EOF > ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.py
#!/usr/bin/env python

domain_home = os.environ.get('DOMAIN_HOME')
admin_server_url = os.environ.get('ADMIN_SERVER_URL')
managed_server_name = os.environ.get('MANAGED_SERVER_NAME')

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
#!/usr/bin/bash

MW_HOME="${MW_HOME}"
EOF
elif [ "${MAJOR_VERSION}" == "12c" ] && [ "${MAJOR_VERSION}" == "14c" ]; then
cat << EOF > ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh
#!/usr/bin/bash

ORACLE_HOME="${ORACLE_HOME}"
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh
export DOMAIN_HOME="${DOMAIN_HOME}"
export ADMIN_SERVER_URL="t3://${ADMIN_SERVER_LISTEN_ADDRESS}:${ADMIN_SERVER_LISTEN_PORT}"
export MANAGED_SERVER_NAME="${MANAGED_SERVER_NAME}"
EOF

if [ "${MAJOR_VERSION}" == "11g" ]; then
cat << EOF >> ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh

${MW_HOME}/wlserver_10.3/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.py
EOF
elif [ "${MAJOR_VERSION}" == "12c" ] && [ "${MAJOR_VERSION}" == "14c" ]; then
cat << EOF >> ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh

${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.py
EOF
fi

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/shutdown-${MANAGED_SERVER_NAME}.sh
