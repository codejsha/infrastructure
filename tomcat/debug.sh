######################################################################

### verbose
CATALINA_OPTS="${CATALINA_OPTS} -verbose:class"
CATALINA_OPTS="${CATALINA_OPTS} -verbose:gc"
CATALINA_OPTS="${CATALINA_OPTS} -verbose:jni"
export CATALINA_OPTS

######################################################################

### java.util.logging (juli)

### session
java.util.logging.ConsoleHandler.level = FINEST
org.apache.catalina.session.level = FINEST

### cluster
java.util.logging.ConsoleHandler.level = FINEST
org.apache.catalina.tribes.level = FINEST
