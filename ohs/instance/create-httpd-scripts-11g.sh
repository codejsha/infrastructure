#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

source ./env-base-11g.sh
source ./env-component-11g.sh

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_HOME="${INSTANCE_HOME}"

######################################################################

### replace pattern with string
TEMP="\${ORACLE_HOME}"
VAR_INSTANCE_HOME="${INSTANCE_HOME/${ORACLE_HOME}/${TEMP}}"
TEMP="\${INSTANCE_NAME}"
VAR_INSTANCE_HOME="${VAR_INSTANCE_HOME/${INSTANCE_NAME}/${TEMP}}"

######################################################################

cat <<EOF > ${INSTANCE_HOME}/check-config.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-version.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -v
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-compile-settings.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -V
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-vhosts-settings.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_VHOSTS
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-run-settings.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -D DUMP_RUN_CFG
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-settings.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

# \${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -S
\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_VHOSTS -D DUMP_RUN_CFG
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-load-modules.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

# \${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -M
\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_MODULES
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-include-files.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: func \${FUNCNAME[0]}: status \${?}"' ERR
export PS4="\e[33;1m+ \e[0m"
set -o xtrace

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_INCLUDES
EOF

######################################################################

chmod 750 ${INSTANCE_HOME}/check-config.sh
chmod 750 ${INSTANCE_HOME}/get-version.sh
chmod 750 ${INSTANCE_HOME}/get-compile-settings.sh
chmod 750 ${INSTANCE_HOME}/get-vhosts-settings.sh
chmod 750 ${INSTANCE_HOME}/get-run-settings.sh
chmod 750 ${INSTANCE_HOME}/get-settings.sh
chmod 750 ${INSTANCE_HOME}/get-load-modules.sh
chmod 750 ${INSTANCE_HOME}/get-include-files.sh
