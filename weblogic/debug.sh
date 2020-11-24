### verbose
JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:class"
JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:gc"
JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:jni"

######################################################################

### debug
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"

### debug all
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.LogSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.LoggerSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"

######################################################################

### ssl debug
JAVA_OPTIONS="${JAVA_OPTIONS} -Djavax.net.debug=all"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dssl.debug=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"

######################################################################

### jta debug

### xa
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTA2PC=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAXA=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAJDBC=true"
### JDBCXADebugLevel=20  # connection pool properties

### non-xa
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTANonXA=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAJDBC=true"
### JDBCXADebugLevel=20  # connection pool properties
