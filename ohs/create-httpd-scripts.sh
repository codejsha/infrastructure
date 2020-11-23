#!/bin/bash

source ./env-base.sh
source ./env-component.sh

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="${DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

######################################################################

cat <<EOF > ${DOMAIN_HOME}/check-config.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="\${ORACLE_HOME}/user_projects/domains/\${DOMAIN_NAME}"
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
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="\${ORACLE_HOME}/user_projects/domains/\${DOMAIN_NAME}"
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
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="\${ORACLE_HOME}/user_projects/domains/\${DOMAIN_NAME}"
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

cat <<EOF > ${DOMAIN_HOME}/get-dump-vhosts.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="\${ORACLE_HOME}/user_projects/domains/\${DOMAIN_NAME}"
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

cat <<EOF > ${DOMAIN_HOME}/get-dump-run-cfg.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="\${ORACLE_HOME}/user_projects/domains/\${DOMAIN_NAME}"
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

cat <<EOF > ${DOMAIN_HOME}/get-dump-settings.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="\${ORACLE_HOME}/user_projects/domains/\${DOMAIN_NAME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -S
# \${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_VHOSTS -D DUMP_RUN_CFG
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-dump-modules.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="\${ORACLE_HOME}/user_projects/domains/\${DOMAIN_NAME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PRODUCT_HOME="\${ORACLE_HOME}/ohs"
LD_LIBRARY_PATH="\${ORACLE_HOME}/lib:\${ORACLE_HOME}/ohs/lib:\${ORACLE_HOME}/oracle_common/lib"
ORACLE_INSTANCE="\${DOMAIN_HOME}"
COMPONENT_TYPE="OHS"
CONFIG=\${DOMAIN_HOME}/config/fmwconfig/components/\${COMPONENT_TYPE}/instances/\${COMPONENT_NAME}/httpd.conf
export ORACLE_HOME PRODUCT_HOME LD_LIBRARY_PATH ORACLE_INSTANCE COMPONENT_TYPE COMPONENT_NAME CONFIG

\${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -M
# \${ORACLE_HOME}/ohs/bin/httpd -DOHS_MPM_EVENT -f \${CONFIG} -t -D DUMP_MODULES
EOF

######################################################################

cat <<EOF > ${DOMAIN_HOME}/get-dump-includes.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

ORACLE_HOME="${ORACLE_HOME}"
DOMAIN_NAME="${DOMAIN_NAME}"
DOMAIN_HOME="\${ORACLE_HOME}/user_projects/domains/\${DOMAIN_NAME}"
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

cat <<EOF > ${DOMAIN_HOME}/get-links-dump.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -x

# HOSTNAME_IP_ADDRESS="$(hostname -i)"
LISTEN_ADDRESS="127.0.0.1"
LISTEN_PORT="80"

links -dump http://\${LISTEN_ADDRESS}:\${LISTEN_PORT}/server-status
EOF

######################################################################

chmod 750 ${DOMAIN_HOME}/check-config.sh
chmod 750 ${DOMAIN_HOME}/get-version.sh
chmod 750 ${DOMAIN_HOME}/get-compile-settings.sh
chmod 750 ${DOMAIN_HOME}/get-dump-vhosts.sh
chmod 750 ${DOMAIN_HOME}/get-dump-run-cfg.sh
chmod 750 ${DOMAIN_HOME}/get-dump-settings.sh
chmod 750 ${DOMAIN_HOME}/get-dump-modules.sh
chmod 750 ${DOMAIN_HOME}/get-dump-includes.sh
chmod 750 ${DOMAIN_HOME}/get-links-dump.sh
