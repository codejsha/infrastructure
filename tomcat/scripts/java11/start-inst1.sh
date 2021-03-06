#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

INSTANCE_NAME="inst1"
export JAVA_HOME="/usr/lib/jvm/java-11"
export JRE_HOME="/usr/lib/jvm/jre-11"
export CATALINA_HOME="/usr/local/tomcat"
export CATALINA_BASE="${CATALINA_HOME}/instances/${INSTANCE_NAME}"

LOG_DIR="${CATALINA_BASE}/logs"
export CATALINA_OUT="${LOG_DIR}/catalina.out"
export CATALINA_PID="${CATALINA_BASE}/tomcat.pid"

CURRENT_USER="$(id -un)"
if [ "${CURRENT_USER}" == "root" ]; then
    echo "[ERROR] The current user is root!"
    exit
fi

CATALINA_OPTS="${CATALINA_OPTS} -D${INSTANCE_NAME}"
CATALINA_OPTS="${CATALINA_OPTS} -Xms1024m -Xmx1024m"
CATALINA_OPTS="${CATALINA_OPTS} -XX:NewSize=384m -XX:MaxNewSize=384m"
CATALINA_OPTS="${CATALINA_OPTS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
# CATALINA_OPTS="${CATALINA_OPTS} -XX:+UseParallelGC"
CATALINA_OPTS="${CATALINA_OPTS} -XX:+UseG1GC"
CATALINA_OPTS="${CATALINA_OPTS} -XX:MaxGCPauseMillis=200"
CATALINA_OPTS="${CATALINA_OPTS} -XX:InitiatingHeapOccupancyPercent=45"
CATALINA_OPTS="${CATALINA_OPTS} -Xlog:gc*=info:file=${LOG_DIR}/gc.${INSTANCE_NAME}.log:time,pid,tid,level,tags"
# CATALINA_OPTS="${CATALINA_OPTS} -Xlog:gc*=info:file=${LOG_DIR}/gc.${INSTANCE_NAME}.log:time,pid,tid,level,tags:filecount=30,filesize=8K"
CATALINA_OPTS="${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
CATALINA_OPTS="${CATALINA_OPTS} -XX:HeapDumpPath=${LOG_DIR}/dump"
export CATALINA_OPTS

CATALINA_OPTS="${CATALINA_OPTS} -Djava.net.preferIPv4Stack=true"
CATALINA_OPTS="${CATALINA_OPTS} -Djava.net.preferIPv6Addresses=false"
CATALINA_OPTS="${CATALINA_OPTS} -Djava.security.egd=file:///dev/urandom"
export CATALINA_OPTS

# CATALINA_OPTS="${CATALINA_OPTS} -Xlog:class+load=info,class+unload=info:stdout:time,level,tags"
# CATALINA_OPTS="${CATALINA_OPTS} -Xlog:module*=info:stdout:time,level,tags"
# CATALINA_OPTS="${CATALINA_OPTS} -verbose:jni"
# export CATALINA_OPTS

# CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote"
# CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote.host=test.example.com"
# CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote.port=8050"
# CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote.ssl=false"
# CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote.authenticate=false"
# export CATALINA_OPTS

touch ${CATALINA_OUT}
${CATALINA_HOME}/bin/startup.sh
tail -f ${CATALINA_OUT}
