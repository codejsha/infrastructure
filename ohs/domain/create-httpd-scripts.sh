#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base.sh
source ./env-component.sh

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

######################################################################

### replace pattern with string
TEMP="\${ORACLE_HOME}"
VAR_DOMAIN_HOME="${DOMAIN_HOME/${ORACLE_HOME}/${TEMP}}"
TEMP="\${DOMAIN_NAME}"
VAR_DOMAIN_HOME="${VAR_DOMAIN_HOME/${DOMAIN_NAME}/${TEMP}}"

######################################################################

cat <<EOF > ${DOMAIN_HOME}/check-config.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-version.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -v
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-compile-settings.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -V
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-vhosts-settings.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_VHOSTS
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-run-settings.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -D DUMP_RUN_CFG
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-settings.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

# \${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -S
\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_VHOSTS -D DUMP_RUN_CFG
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-load-modules.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

# \${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -M
\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_MODULES
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-include-files.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${VAR_DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_INCLUDES
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/check-config.sh
chmod 750 ${DOMAIN_HOME}/get-version.sh
chmod 750 ${DOMAIN_HOME}/get-compile-settings.sh
chmod 750 ${DOMAIN_HOME}/get-vhosts-settings.sh
chmod 750 ${DOMAIN_HOME}/get-run-settings.sh
chmod 750 ${DOMAIN_HOME}/get-settings.sh
chmod 750 ${DOMAIN_HOME}/get-load-modules.sh
chmod 750 ${DOMAIN_HOME}/get-include-files.sh
