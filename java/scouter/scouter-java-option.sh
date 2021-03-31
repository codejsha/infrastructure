######################################################################

### JAVA_OPTIONS

SCOUTER_AGENT_DIR="/svc/apm/scouter/agent.java"
JAVA_OPTIONS="${JAVA_OPTIONS} -javaagent:${SCOUTER_AGENT_DIR}/scouter.agent.jar"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dscouter.config=${SCOUTER_AGENT_DIR}/conf/scouter-${SERVER_NAME}.conf"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dobj_name=${SERVER_NAME}"
export JAVA_OPTIONS

######################################################################

### JAVA_OPTS

SCOUTER_AGENT_DIR="/svc/apm/scouter/agent.java"
JAVA_OPTS="${JAVA_OPTS} -javaagent:${SCOUTER_AGENT_DIR}/scouter.agent.jar"
JAVA_OPTS="${JAVA_OPTS} -Dscouter.config=${SCOUTER_AGENT_DIR}/conf/scouter-${SERVER_NAME}.conf"
JAVA_OPTS="${JAVA_OPTS} -Dobj_name=${SERVER_NAME}"
export JAVA_OPTS
