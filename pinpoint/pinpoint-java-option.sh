######################################################################

PINPOINT_VERSION="2.1.0"
PINPOINT_AGENT_LIB_DIR="/svc/lib"
PINPOINT_AGENT_ID="agent1"
PINPOINT_APP_NAME="failovertest"

JAVA_OPTIONS="${JAVA_OPTIONS} -javaagent:${PINPOINT_AGENT_LIB_DIR}/pinpoint-bootstrap-${PINPOINT_VERSION}.jar"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dpinpoint.agentId=${PINPOINT_AGENT_ID}"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dpinpoint.applicationName=${PINPOINT_APP_NAME}"
export JAVA_OPTIONS

######################################################################

PINPOINT_VERSION="2.1.0"
PINPOINT_AGENT_LIB_DIR="/svc/lib"
PINPOINT_AGENT_ID="agent1"
PINPOINT_APP_NAME="failovertest"

CATALINA_OPTS="${CATALINA_OPTS} -javaagent:${PINPOINT_AGENT_LIB_DIR}/pinpoint-bootstrap-${PINPOINT_VERSION}.jar"
CATALINA_OPTS="${CATALINA_OPTS} -Dpinpoint.agentId=${PINPOINT_AGENT_ID}"
CATALINA_OPTS="${CATALINA_OPTS} -Dpinpoint.applicationName=${PINPOINT_APP_NAME}"
export CATALINA_OPTS
