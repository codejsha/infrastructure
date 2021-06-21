#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

source ../env-base.sh

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

######################################################################

cat <<EOF > ${DOMAIN_HOME}/scripts/change_nodemgr_password.py
#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']


######################################################################


def change_nodemgr_password(_domain_name, _admin_username, _admin_password):
    cd('/SecurityConfiguration/' + _domain_name)
    cmo.setNodeManagerUsername(_admin_username)
    cmo.setNodeManagerPassword(_admin_password)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

change_nodemgr_password(domain_name, admin_username, admin_password)

save()
activate()
exit()
EOF

######################################################################

if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12. ]]; then
cat <<EOF > ${DOMAIN_HOME}/scripts/change-nodemgr-password.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o errexit
set -o errtrace
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
export DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat <<EOF > ${DOMAIN_HOME}/scripts/change-nodemgr-password.sh
#!/bin/bash
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o errexit
set -o errtrace
set -o xtrace

MW_HOME="${MW_HOME}"
export DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME_11}"
EOF
fi

cat <<EOF >> ${DOMAIN_HOME}/scripts/change-nodemgr-password.sh
export ADMIN_SERVER_LISTEN_ADDRESS="${ADMIN_SERVER_LISTEN_ADDRESS}"
export ADMIN_SERVER_LISTEN_PORT="${ADMIN_SERVER_LISTEN_PORT}"
export ADMIN_USERNAME="\${1:-"weblogic"}"
export ADMIN_PASSWORD="\${2:-"welcome1"}"
DATETIME="\$(date +'%Y%m%d_%H%M%S')"
NEW_USERNAME="\${ADMIN_USERNAME}"
NEW_PASSWORD="\${ADMIN_PASSWORD}"

mv \${DOMAIN_HOME}/config/nodemanager/nm_password.properties \${DOMAIN_HOME}/config/nodemanager/nm_password.properties.\${DATETIME}
cat <<EOF > \${DOMAIN_HOME}/config/nodemanager/nm_password.properties
username=\${NEW_USERNAME}
password=\${NEW_PASSWORD}
EOF
echo EOF >> ${DOMAIN_HOME}/scripts/change-nodemgr-password.sh

if [[ ${WEBLOGIC_VERSION} =~ ^14.1|^12. ]]; then
cat <<EOF >> ${DOMAIN_HOME}/scripts/change-nodemgr-password.sh

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh change_nodemgr_password.py
EOF
elif [[ ${WEBLOGIC_VERSION} =~ ^10.3 ]]; then
cat <<EOF >> ${DOMAIN_HOME}/scripts/change-nodemgr-password.sh

export CONFIG_JVM_ARGS="\${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
\${MW_HOME}/wlserver_10.3/common/bin/wlst.sh change_nodemgr_password.py
EOF
fi

######################################################################

chmod 750 ${DOMAIN_HOME}/scripts/change-nodemgr-password.sh
