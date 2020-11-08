#!/usr/bin/bash

ORACLE_HOME="/usr/local/ohs"
DOMAIN_NAME="base_domain"
DOMAIN_HOME="${ORACLE_HOME}/user_projects/domains/${DOMAIN_NAME}"
LOG_DIR="\${DOMAIN_HOME}/logs"
COMPONENT_NAME="ohs1"

######################################################################

cat <<EOF > "${DOMAIN_HOME}/start-nodemanager.sh"
#!/usr/bin/bash

DOMAIN_HOME="${DOMAIN_HOME}"
LOG_DIR="${LOG_DIR}"
GET_DATE="$(date +'%Y%m%d_%H%M%S')"

PID="\$(pgrep -xa java | grep \${DOMAIN_HOME} | grep NodeManager | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
  echo "[ERROR] NodeManager (pid $\{PID}) is already running!"
  exit
fi

if [ -f ${LOG_DIR}/nohup.NodeManager.out ]; then
  mv ${LOG_DIR}/nohup.NodeManager.out ${LOG_DIR}/NodeManager/nohup.NodeManager.\${GET_DATE}.out
fi

touch ${LOG_DIR}/nohup.NodeManager.out
nohup \${DOMAIN_HOME}/bin/startNodeManager.sh > ${LOG_DIR}/nohup.NodeManager.out 2>&1 &
tail -f ${LOG_DIR}/nohup.NodeManager.out
EOF

cat <<EOF > "${DOMAIN_HOME}/stop-nodemanager.sh"
#!/usr/bin/bash

DOMAIN_HOME="${DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

PID="\$(pgrep -xa java | grep \${DOMAIN_HOME} | grep NodeManager | awk '{print \$1}')"
kill -9 \${PID}
EOF

######################################################################

cat <<EOF > "${DOMAIN_HOME}/start-${COMPONENT_NAME}.sh"
#!/usr/bin/bash

DOMAIN_HOME="${DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

\${DOMAIN_HOME}/bin/startComponent.sh \${COMPONENT_NAME} storeUserConfig
EOF

cat <<EOF > "${DOMAIN_HOME}/stop-${COMPONENT_NAME}.sh"
#!/usr/bin/bash

DOMAIN_HOME="${DOMAIN_HOME}"
COMPONENT_NAME="${COMPONENT_NAME}"

\${DOMAIN_HOME}/bin/stopComponent.sh \${COMPONENT_NAME}
EOF

######################################################################

mkdir -p "$(eval echo ${LOG_DIR}/NodeManager)"
mkdir -p "$(eval echo ${LOG_DIR}/${COMPONENT_NAME})"

ln -snf ${DOMAIN_HOME} ${ORACLE_HOME}/${DOMAIN_NAME}
ln -snf ${DOMAIN_HOME}/config/fmwconfig/components/OHS/${COMPONENT_NAME} ${DOMAIN_HOME}/config/${COMPONENT_NAME}stg
ln -snf ${DOMAIN_HOME}/config/fmwconfig/components/OHS/instances/${COMPONENT_NAME} ${DOMAIN_HOME}/config/${COMPONENT_NAME}rt

chmod 750 ${DOMAIN_HOME}/start-nodemanager.sh
chmod 750 ${DOMAIN_HOME}/stop-nodemanager.sh
chmod 750 ${DOMAIN_HOME}/start-${COMPONENT_NAME}.sh
chmod 750 ${DOMAIN_HOME}/stop-${COMPONENT_NAME}.sh

######################################################################
