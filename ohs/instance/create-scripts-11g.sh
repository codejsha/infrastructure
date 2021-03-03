#!/bin/bash

source ./env-base-11g.sh
source ./env-component-11g.sh

MW_HOME="${MW_HOME}"
INSTANCE_NAME="${INSTANCE_NAME}"
INSTANCE_HOME="${INSTANCE_HOME}"
LOG_DIR="${LOG_DIR}"
COMPONENT_NAME="${COMPONENT_NAME}"

######################################################################

cat <<EOF > ${INSTANCE_HOME}/start-opmn.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl start
EOF

cat <<EOF > ${INSTANCE_HOME}/stop-opmn.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl stop
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-status.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl status -l
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/start-all.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl startall
EOF

cat <<EOF > ${INSTANCE_HOME}/stop-all.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl stopall
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/start-${COMPONENT_NAME}.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

INSTANCE_HOME="${INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

\${INSTANCE_HOME}/bin/opmnctl startproc ias-component=\${COMPONENT_NAME} process-type=OHS
EOF

cat <<EOF > ${INSTANCE_HOME}/stop-${COMPONENT_NAME}.sh
#!/bin/bash
export PS4="\e[33;1m+ \e[0m"; set -o xtrace

INSTANCE_HOME="${INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

\${INSTANCE_HOME}/bin/opmnctl stopproc ias-component=\${COMPONENT_NAME} process-type=OHS
EOF

######################################################################

mkdir -p ${LOG_DIR}

ln -snf ${INSTANCE_HOME} ${MW_HOME}/${INSTANCE_NAME}
ln -snf ${INSTANCE_HOME}/config/OHS/${COMPONENT_NAME} ${INSTANCE_HOME}/config/${COMPONENT_NAME}
ln -snf ${INSTANCE_HOME}/config/OPMN/opmn ${INSTANCE_HOME}/config/opmn
ln -snf ${INSTANCE_HOME}/diagnostics/logs/OPMN/opmn ${LOG_DIR}/opmn
ln -snf ${INSTANCE_HOME}/diagnostics/logs/OHS/${COMPONENT_NAME} ${LOG_DIR}/${COMPONENT_NAME}

chmod 750 ${INSTANCE_HOME}/start-opmn.sh
chmod 750 ${INSTANCE_HOME}/stop-opmn.sh
chmod 750 ${INSTANCE_HOME}/start-all.sh
chmod 750 ${INSTANCE_HOME}/stop-all.sh
chmod 750 ${INSTANCE_HOME}/start-${COMPONENT_NAME}.sh
chmod 750 ${INSTANCE_HOME}/stop-${COMPONENT_NAME}.sh
chmod 750 ${INSTANCE_HOME}/get-status.sh
