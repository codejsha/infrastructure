######################################################################

### JAVA_OPTIONS

PINPOINT_VERSION="2.1.0"
PINPOINT_AGENT_LIB_DIR="/svc/lib"
PINPOINT_AGENT_ID="agent1"
PINPOINT_APP_NAME="failovertest"
JAVA_OPTIONS="${JAVA_OPTIONS} -javaagent:${PINPOINT_AGENT_LIB_DIR}/pinpoint-bootstrap-${PINPOINT_VERSION}.jar"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dpinpoint.agentId=${PINPOINT_AGENT_ID}"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dpinpoint.applicationName=${PINPOINT_APP_NAME}"
export JAVA_OPTIONS

######################################################################

### JAVA_OPTS

PINPOINT_VERSION="2.1.0"
PINPOINT_AGENT_LIB_DIR="/svc/lib"
PINPOINT_AGENT_ID="agent1"
PINPOINT_APP_NAME="failovertest"
JAVA_OPTS="${JAVA_OPTS} -javaagent:${PINPOINT_AGENT_LIB_DIR}/pinpoint-bootstrap-${PINPOINT_VERSION}.jar"
JAVA_OPTS="${JAVA_OPTS} -Dpinpoint.agentId=${PINPOINT_AGENT_ID}"
JAVA_OPTS="${JAVA_OPTS} -Dpinpoint.applicationName=${PINPOINT_APP_NAME}"
export JAVA_OPTS
