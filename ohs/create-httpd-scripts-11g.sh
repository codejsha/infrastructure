#!/bin/bash

source ./env-base-11g.sh
source ./env-component-11g.sh

MW_HOME="${MW_HOME}"
ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_HOME="${INSTANCE_HOME}"

######################################################################

### substitute variables
TEMP="\${ORACLE_HOME}"
VAR_INSTANCE_HOME="${INSTANCE_HOME/${ORACLE_HOME}/${TEMP}}"
TEMP="\${INSTANCE_NAME}"
VAR_INSTANCE_HOME="${INSTANCE_HOME/${INSTANCE_NAME}/${TEMP}}"

######################################################################

cat <<EOF > ${ORACLE_HOME}/check-config.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

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

cat <<EOF > ${ORACLE_HOME}/get-version.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

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

cat <<EOF > ${ORACLE_HOME}/get-compile-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

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

cat <<EOF > ${ORACLE_HOME}/get-vhosts-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

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

cat <<EOF > ${ORACLE_HOME}/get-run-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

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

cat <<EOF > ${ORACLE_HOME}/get-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -S
# \${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_VHOSTS -D DUMP_RUN_CFG
EOF

######################################################################

cat <<EOF > ${ORACLE_HOME}/get-load-modules.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${VAR_INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib"
ORACLE_INSTANCE="\${INSTANCE_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${INSTANCE_HOME}/config/\${COMPONENT_TYPE}/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -M
# \${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_MODULES
EOF

######################################################################

cat <<EOF > ${ORACLE_HOME}/get-include-files.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

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

chmod 750 ${ORACLE_HOME}/check-config.sh
chmod 750 ${ORACLE_HOME}/get-version.sh
chmod 750 ${ORACLE_HOME}/get-compile-settings.sh
chmod 750 ${ORACLE_HOME}/get-vhosts-settings.sh
chmod 750 ${ORACLE_HOME}/get-run-settings.sh
chmod 750 ${ORACLE_HOME}/get-settings.sh
chmod 750 ${ORACLE_HOME}/get-load-modules.sh
chmod 750 ${ORACLE_HOME}/get-include-files.sh
