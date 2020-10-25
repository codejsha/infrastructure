#!/usr/bin/bash

source ./env-base.sh

######################################################################

### transform variables
TEMP="\${JBOSS_HOME}"
VAR_JBOSS_BASE_DIR="${JBOSS_BASE_DIR/${JBOSS_HOME}/${TEMP}}"
TEMP="\${JBOSS_BASE_DIR}"
VAR_JBOSS_CONFIG_DIR="${JBOSS_CONFIG_DIR/${JBOSS_BASE_DIR}/${TEMP}}"
TEMP="\${JBOSS_BASE_DIR}"
VAR_JBOSS_LOG_DIR="${JBOSS_LOG_DIR/${JBOSS_BASE_DIR}/${TEMP}}"
TEMP="\${JBOSS_LOG_DIR}"
VAR_DUMP_LOG_DIR="${DUMP_LOG_DIR/${JBOSS_LOG_DIR}/${TEMP}}"

######################################################################

### start script
cat <<EOF > ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
#!/usr/bin/bash

INSTANCE_NAME="${INSTANCE_NAME}"
export JAVA_HOME="${JAVA_HOME}"
export JBOSS_HOME="${JBOSS_HOME}"
export JBOSS_BASE_DIR="${VAR_JBOSS_BASE_DIR}"
export JBOSS_LOG_DIR="${VAR_JBOSS_LOG_DIR}"
export JBOSS_CONFIG_DIR="${VAR_JBOSS_CONFIG_DIR}"
SERVER_CONFIG_FILE="${SERVER_CONFIG_FILE}"
GET_DATE="\$(date +'%Y%m%d_%H%M%S')"

BIND_ADDRESS="${BIND_ADDRESS}"
BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
BIND_ADDRESS_PRIVATE="${BIND_ADDRESS_PRIVATE}"
DEFAULT_MULTICAST_ADDRESS="${DEFAULT_MULTICAST_ADDRESS}"
PORT_OFFSET="${PORT_OFFSET}"

EOF

if [[ ${JAVA_VERSION} =~ ^1.8 ]]; then
cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
JAVA_OPTS="\${JAVA_OPTS} -D\${INSTANCE_NAME}"
JAVA_OPTS="\${JAVA_OPTS} -Xms1024m -Xmx1024m"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.node.name=\${INSTANCE_NAME}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address=\${BIND_ADDRESS}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address.management=\${BIND_ADDRESS_MGMT}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address.private=\${BIND_ADDRESS_PRIVATE}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.default.multicast.address=\${DEFAULT_MULTICAST_ADDRESS}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.socket.binding.port-offset=${PORT_OFFSET}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.server.config.dir=\${JBOSS_CONFIG_DIR}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.server.log.dir=\${JBOSS_LOG_DIR}"
JAVA_OPTS="\${JAVA_OPTS} -Xloggc:\${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log"
JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintGCDetails"
JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintTenuringDistribution"
JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintGCDateStamps"
JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintGCTimeStamps"
JAVA_OPTS="\${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
JAVA_OPTS="\${JAVA_OPTS} -XX:HeapDumpPath=${VAR_DUMP_LOG_DIR}"
# JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintFlagsFinal"
# JAVA_OPTS="\${JAVA_OPTS} -verbose:class"
# JAVA_OPTS="\${JAVA_OPTS} -verbose:module"
# JAVA_OPTS="\${JAVA_OPTS} -verbose:jni"
EOF
elif [[ ${JAVA_VERSION} =~ ^11 ]]; then
cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
JAVA_OPTS="\${JAVA_OPTS} -D\${INSTANCE_NAME}"
JAVA_OPTS="\${JAVA_OPTS} -Xms1024m -Xmx1024m"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.node.name=\${INSTANCE_NAME}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address=\${BIND_ADDRESS}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address.management=\${BIND_ADDRESS_MGMT}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.bind.address.private=\${BIND_ADDRESS_PRIVATE}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.default.multicast.address=\${DEFAULT_MULTICAST_ADDRESS}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.socket.binding.port-offset=\${PORT_OFFSET}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.server.config.dir=\${JBOSS_CONFIG_DIR}"
JAVA_OPTS="\${JAVA_OPTS} -Djboss.server.log.dir=\${JBOSS_LOG_DIR}"
JAVA_OPTS="\${JAVA_OPTS} -Xlog:gc*=info:file=\${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log:time,pid,tid,level,tags"
JAVA_OPTS="\${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
JAVA_OPTS="\${JAVA_OPTS} -XX:HeapDumpPath=${VAR_DUMP_LOG_DIR}"
# JAVA_OPTS="\${JAVA_OPTS} -XX:+PrintFlagsFinal"
# JAVA_OPTS="\${JAVA_OPTS} -Xlog:class+load=info,class+unload=info:stdout:time,level,tags"
# JAVA_OPTS="\${JAVA_OPTS} -Xlog:module*=info:stdout:time,level,tags"
# JAVA_OPTS="\${JAVA_OPTS} -verbose:jni"
EOF
fi

cat <<EOF >> ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
JAVA_OPTS="\${JAVA_OPTS} -Djava.security.egd=file:///dev/urandom"
JAVA_OPTS="\${JAVA_OPTS} -Djava.net.preferIPv4Stack=true"
JAVA_OPTS="\${JAVA_OPTS} -Djava.net.preferIPv6Addresses=false"
export JAVA_OPTS

if [ -f \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out ]; then
    mv \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out \\
        \${JBOSS_LOG_DIR}/\${INSTANCE_NAME}/nohup.\${INSTANCE_NAME}.\${GET_DATE}.out
fi
if [ -f \${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log ]; then
    mv \${JBOSS_LOG_DIR}/gc.\${INSTANCE_NAME}.log \\
        \${JBOSS_LOG_DIR}/\${INSTANCE_NAME}/gc.\${INSTANCE_NAME}.\${GET_DATE}.log
fi

touch \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out
nohup \${JBOSS_HOME}/bin/standalone.sh \\
    --server-config \${SERVER_CONFIG_FILE} \\
    > \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out 2>&1 &
tail -f \${JBOSS_LOG_DIR}/nohup.\${INSTANCE_NAME}.out
EOF

######################################################################

### stop script
cat <<EOF > ${JBOSS_BASE_DIR}/stop-${INSTANCE_NAME}.sh
#!/usr/bin/bash

INSTANCE_NAME="${INSTANCE_NAME}"
export JAVA_HOME="${JAVA_HOME}"
export JBOSS_HOME="${JBOSS_HOME}"
export JBOSS_BASE_DIR="${VAR_JBOSS_BASE_DIR}"
export JBOSS_CONFIG_DIR="${VAR_JBOSS_CONFIG_DIR}"
SERVER_CONFIG_FILE="${SERVER_CONFIG_FILE}"

BIND_ADDRESS_MGMT="${BIND_ADDRESS_MGMT}"
JBOSS_MGMT_HTTP_PORT="${JBOSS_MGMT_HTTP_PORT}"

\${JBOSS_HOME}/bin/jboss-cli.sh \\
    --connect \\
    --controller="\${BIND_ADDRESS_MGMT}:\${JBOSS_MGMT_HTTP_PORT}" \\
    --command=":shutdown"
EOF


######################################################################

### change permission
chmod 750 ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh
chmod 750 ${JBOSS_BASE_DIR}/stop-${INSTANCE_NAME}.sh

### create symbolic link
ln -snf ${JBOSS_BASE_DIR}/start-${INSTANCE_NAME}.sh \
    ${JBOSS_HOME}/start-${INSTANCE_NAME}.sh
ln -snf ${JBOSS_BASE_DIR}/stop-${INSTANCE_NAME}.sh \
    ${JBOSS_HOME}/stop-${INSTANCE_NAME}.sh
