#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

source ../env-base.sh

######################################################################

### replace pattern with string
TEMP="\${JBOSS_HOME}"
VAR_JBOSS_BASE_DIR="${JBOSS_BASE_DIR/${JBOSS_HOME}/${TEMP}}"
TEMP="\${JBOSS_BASE_DIR}"
VAR_JBOSS_CONFIG_DIR="${JBOSS_CONFIG_DIR/${JBOSS_BASE_DIR}/${TEMP}}"
TEMP="\${JBOSS_BASE_DIR}"
VAR_JBOSS_LOG_DIR="${JBOSS_LOG_DIR/${JBOSS_BASE_DIR}/${TEMP}}"

######################################################################

### create start script

cat <<EOF > ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR

INSTANCE_NAME="${INSTANCE_NAME}"
export JAVA_HOME="${JAVA_HOME}"
export JBOSS_HOME="${JBOSS_HOME}"
export JBOSS_BASE_DIR="${VAR_JBOSS_BASE_DIR}"
export JBOSS_CONFIG_DIR="${VAR_JBOSS_CONFIG_DIR}"
export JBOSS_LOG_DIR="${VAR_JBOSS_LOG_DIR}"
SERVER_CONFIG_FILE="${SERVER_CONFIG_FILE}"
DATETIME="\$(date +'%Y%m%d_%H%M%S')"

BIND_ADDRESS="${BIND_ADDRESS}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
BIND_ADDRESS_PRIVATE="${BIND_ADDRESS_PRIVATE}"
DEFAULT_MULTICAST_ADDRESS="${DEFAULT_MULTICAST_ADDRESS}"
PORT_OFFSET="${PORT_OFFSET}"

CURRENT_USER="\$(id -un)"
if [ "\${CURRENT_USER}" == "root" ]; then
    echo "[ERROR] The current user is root!"
    exit
fi

PID="\$(pgrep -xa java | grep \${INSTANCE_NAME} | awk '{print \$1}')"
if [ -n "\${PID}" ]; then
    echo "[ERROR] The \${INSTANCE_NAME} (pid \${PID}) is already running!"
    exit
fi

JAVA_OPTS="\${JAVA_OPTS} -D\${INSTANCE_NAME}"
JAVA_OPTS="\${JAVA_OPTS} -Xms1024m -Xmx1024m"
EOF

if [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
JAVA_OPTS="\${JAVA_OPTS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
# JAVA_OPTS="\${JAVA_OPTS} -XX:+UseParallelGC"
JAVA_OPTS="\${JAVA_OPTS} -XX:+UseG1GC"
JAVA_OPTS="\${JAVA_OPTS} -XX:MaxGCPauseMillis=200"
JAVA_OPTS="\${JAVA_OPTS} -XX:InitiatingHeapOccupancyPercent=45"
JAVA_OPTS="\${JAVA_OPTS} -Xlog:gc*=info:file=\${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log:time,pid,tid,level,tags"
# JAVA_OPTS="\${JAVA_OPTS} -Xlog:gc*=info:file=\${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log:time,pid,tid,level,tags:filecount=30,filesize=1M"
JAVA_OPTS="\${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
JAVA_OPTS="\${JAVA_OPTS} -XX:HeapDumpPath=\${JBOSS_LOG_DIR}/dump"
export JAVA_OPTS
EOF
elif [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
JAVA_OPTS="\${JAVA_OPTS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
JAVA_OPTS="\${JAVA_OPTS} -XX:+UseParallelGC"
JAVA_OPTS="\${JAVA_OPTS} -XX:-UseAdaptiveSizePolicy"
JAVA_OPTS="\${JAVA_OPTS} -XX:+DisableExplicitGC"
JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintGCDetails"
JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintGCDateStamps"
JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintGCTimeStamps"
JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintHeapAtGC"
JAVA_OPTS="\${JAVA_OPTS} -Xloggc:\${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log"
# JAVA_OPTS="\${JAVA_OPTS} -XX:+UseGCLogFileRotation"
# JAVA_OPTS="\${JAVA_OPTS} -XX:+NumberOfGCLogFiles=30"
# JAVA_OPTS="\${JAVA_OPTS} -XX:+GCLogFileSize=1M"
JAVA_OPTS="\${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
JAVA_OPTS="\${JAVA_OPTS} -XX:HeapDumpPath=\${JBOSS_LOG_DIR}/dump"
export JAVA_OPTS
EOF
fi

cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh

JAVA_OPTS="\${JAVA_OPTS} -Djava.net.preferIPv4Stack=true"
JAVA_OPTS="\${JAVA_OPTS} -Djava.net.preferIPv6Addresses=false"
JAVA_OPTS="\${JAVA_OPTS} -Djava.security.egd=file:///dev/urandom"
export JAVA_OPTS

JAVA_OPTS="\${JAVA_OPTS} -Djboss.node.name=\${INSTANCE_NAME}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address=\${BIND_ADDRESS}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address.management=\${BIND_ADDRESS_MGMT}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address.private=\${BIND_ADDRESS_PRIVATE}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.default.multicast.address=\${DEFAULT_MULTICAST_ADDRESS}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.socket.binding.port-offset=\${PORT_OFFSET}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.server.config.dir=\${JBOSS_CONFIG_DIR}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.server.log.dir=\${JBOSS_LOG_DIR}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.tx.node.id=\${INSTANCE_NAME}"
export JAVA_OPTS

JAVA_OPTS="\${JAVA_OPTS} -Dwildfly.statistics-enabled=true"
JAVA_OPTS="\${JAVA_OPTS} -Dwildfly.datasources.statistics-enabled=true"
JAVA_OPTS="\${JAVA_OPTS} -Dwildfly.ejb3.statistics-enabled=true"
JAVA_OPTS="\${JAVA_OPTS} -Dwildfly.transactions.statistics-enabled=true"
JAVA_OPTS="\${JAVA_OPTS} -Dwildfly.undertow.statistics-enabled=true"
JAVA_OPTS="\${JAVA_OPTS} -Dwildfly.webservices.statistics-enabled=true"
export JAVA_OPTS

EOF

if [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
# JAVA_OPTS="\${JAVA_OPTS} -Xlog:class+load=info,class+unload=info:stdout:time,level,tags"
# JAVA_OPTS="\${JAVA_OPTS} -Xlog:module*=info:stdout:time,level,tags"
# JAVA_OPTS="\${JAVA_OPTS} -verbose:jni"
# export JAVA_OPTS
EOF
elif [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
# JAVA_OPTS="\${JAVA_OPTS} -verbose:class"
# JAVA_OPTS="\${JAVA_OPTS} -verbose:module"
# JAVA_OPTS="\${JAVA_OPTS} -verbose:jni"
# export JAVA_OPTS
EOF
fi

cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh

if [ -f "\${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out" ]; then
    mv \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out \\
        \${JBOSS_LOG_DIR}/backup/nohup.\${INSTANCE_NAME}.\${DATETIME}.out
fi
if [ -f "\${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log" ]; then
    mv \${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log \\
        \${JBOSS_LOG_DIR}/backup/gc.\${INSTANCE_NAME}.\${DATETIME}.log
fi

touch \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out
nohup \${JBOSS_HOME}/bin/standalone.sh \\
    --server-config \${SERVER_CONFIG_FILE} \\
    > \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out 2>&1 &
tail -f \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out
EOF

######################################################################

### create stop script

cat <<EOF > ${JBOSS_BASE_DIR}/stop-${INSTANCE_NAME}.sh
#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "\${BASH_SOURCE[0]}: line \${LINENO}: status \${?}: user \${USER}: func \${FUNCNAME[0]}"' ERR

INSTANCE_NAME="${INSTANCE_NAME}"
export JAVA_HOME="${JAVA_HOME}"
export JBOSS_HOME="${JBOSS_HOME}"
export JBOSS_BASE_DIR="${VAR_JBOSS_BASE_DIR}"
export JBOSS_CONFIG_DIR="${VAR_JBOSS_CONFIG_DIR}"
SERVER_CONFIG_FILE="${SERVER_CONFIG_FILE}"

BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

USERNAME="\${USERNAME}"
PASSWORD="\${PASSWORD}"

\${JBOSS_HOME}/bin/jboss-cli.sh \\
    --connect \\
    --user="\${USERNAME}" \\
    --password="\${PASSWORD}" \\
    --controller="\${BIND_ADDRESS_MGMT}:\${JBOSS_MGMT_HTTP_PORT}" \\
    --command=":shutdown"
EOF

######################################################################

### change file permissions
chmod 750 ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
chmod 750 ${JBOSS_BASE_DIR}/stop-${INSTANCE_NAME}.sh

### create symbolic link
ln -snf ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh \
    ${JBOSS_HOME}/start-${INSTANCE_NAME}.sh
ln -snf ${JBOSS_BASE_DIR}/stop-${INSTANCE_NAME}.sh \
    ${JBOSS_HOME}/stop-${INSTANCE_NAME}.sh
