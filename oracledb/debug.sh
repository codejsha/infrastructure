### jdbc debug

EXT_PRE_CLASSPATH="${EXT_PRE_CLASSPATH}:jdbc_g.jar"
export EXT_PRE_CLASSPATH

JAVA_OPTIONS="${JAVA_OPTIONS} -Doracle.jdbc.Trace=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.util.logging.config.file=${DOMAIN_HOME}/jdbc-driver-debug.properties"
JAVA_OPTIONS="${JAVA_OPTIONS} -Doracle.jdbc.LogFile=${LOG_DIR}/jdbc.log"
export JAVA_OPTIONS
