#!/usr/bin/bash

ORACLE_HOME="/usr/local/ohs"
DOMAIN_NAME="base_domain"
DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
COMPONENT_NAME="ohs1"

######################################################################

cat <<EOF > ${DOMAIN_HOME}/check-config.sh
#!/usr/bin/bash

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
#!/usr/bin/bash

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
#!/usr/bin/bash

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
#!/usr/bin/bash

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
#!/usr/bin/bash

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
#!/usr/bin/bash

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
#!/usr/bin/bash

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
#!/usr/bin/bash

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
#!/usr/bin/bash

PORT="80"

links -dump http://127.0.0.1:\${PORT}/server-status
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
