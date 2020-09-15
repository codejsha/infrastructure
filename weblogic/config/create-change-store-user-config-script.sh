#!/usr/bin/bash

source ./env-base.sh

mkdir -p ${DOMAIN_HOME}/scripts

######################################################################

cat <<EOF > ${DOMAIN_HOME}/scripts/change_store_user_config.py
#!/usr/bin/env python

domain_home = os.environ.get('DOMAIN_HOME')
admin_server_url = os.environ.get('ADMIN_SERVER_URL')
admin_username = os.environ.get('ADMIN_USERNAME')
admin_password = os.environ.get('ADMIN_PASSWORD')

######################################################################

connect(admin_username, admin_password, admin_server_url)

storeUserConfig(domain_home + '/security/WebLogicConfig.properties',
                domain_home + '/security/WebLogicKey.properties')

exit()
EOF

######################################################################

if [ "${MAJOR_VERSION}" == "11g" ]; then
cat << EOF > ${DOMAIN_HOME}/scripts/change-store-user-config.sh
#!/usr/bin/bash
MW_HOME="${MW_HOME}"
EOF
elif [ "${MAJOR_VERSION}" == "12c" ] && [ "${MAJOR_VERSION}" == "14c" ]; then
cat << EOF > ${DOMAIN_HOME}/scripts/change-store-user-config.sh
#!/usr/bin/bash
ORACLE_HOME="${ORACLE_HOME}"
EOF
fi

cat << EOF >> ${DOMAIN_HOME}/scripts/change-store-user-config.sh
export DOMAIN_HOME="${DOMAIN_HOME}"
export ADMIN_SERVER_URL="t3://${ADMIN_SERVER_LISTEN_ADDRESS}:${ADMIN_SERVER_LISTEN_PORT}"
export ADMIN_USERNAME="\${1:-weblogic}"
export ADMIN_PASSWORD="\${2:-welcome1}"
EOF

if [ "${MAJOR_VERSION}" == "11g" ]; then
cat << EOF >> ${DOMAIN_HOME}/scripts/change-store-user-config.sh

${MW_HOME}/wlserver_10.3/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/change_store_user_config.py
EOF
elif [ "${MAJOR_VERSION}" == "12c" ] && [ "${MAJOR_VERSION}" == "14c" ]; then
cat << EOF >> ${DOMAIN_HOME}/scripts/change-store-user-config.sh

${ORACLE_HOME}/oracle_common/common/bin/wlst.sh ${DOMAIN_HOME}/scripts/change_store_user_config.py
EOF
fi

chmod 750 ${DOMAIN_HOME}/scripts/change-store-user-config.sh
