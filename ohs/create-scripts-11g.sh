#!/usr/bin/bash

MW_HOME="/usr/local/ohs"
ORACLE_HOME="${MW_HOME}/oracle_wt1"
INSTANCE_NAME="instance1"
INSTANCE_HOME="${ORACLE_HOME}/instances/${INSTANCE_NAME}"
LOG_DIR="${INSTANCE_HOME}/logs"
COMPONENT_NAME="ohs1"

######################################################################

cat <<EOF > ${INSTANCE_HOME}/start-opmn.sh
#!/usr/bin/bash

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl start
EOF

cat <<EOF > ${INSTANCE_HOME}/stop-opmn.sh
#!/usr/bin/bash

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl stop
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/get-status.sh
#!/usr/bin/bash

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl status -l
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/start-all.sh
#!/usr/bin/bash

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl startall
EOF

cat <<EOF > ${INSTANCE_HOME}/stop-all.sh
#!/usr/bin/bash

INSTANCE_HOME="${INSTANCE_HOME}"

\${INSTANCE_HOME}/bin/opmnctl stopall
EOF

######################################################################

cat <<EOF > ${INSTANCE_HOME}/start-${COMPONENT_NAME}.sh
#!/usr/bin/bash

INSTANCE_HOME="${INSTANCE_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

\${INSTANCE_HOME}/bin/opmnctl startproc ias-component=\${COMPONENT_NAME} process-type=OHS
EOF

cat <<EOF > ${INSTANCE_HOME}/stop-${COMPONENT_NAME}.sh
#!/usr/bin/bash

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

######################################################################
