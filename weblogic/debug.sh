######################################################################

### verbose
JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:class"
JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:gc"
JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:jni"
export JAVA_OPTIONS

######################################################################

### debug
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

### debug all
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.LogSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.LoggerSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

######################################################################

### node manager

### nodemanager.properties
LogLevel=FINEST

### start script
JAVA_OPTIONS="${JAVA_OPTIONS} -DLogLevel=FINEST"
export JAVA_OPTIONS

######################################################################

### ssl
JAVA_OPTIONS="${JAVA_OPTIONS} -Djavax.net.debug=all"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dssl.debug=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

######################################################################

### deployment
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugDeployment=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugDeploymentServiceInternal=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugDeploymentServiceTransport=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugDeploymentServiceTransportHttp=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugDeploymentServiceStatusUpdates=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

######################################################################

### application container
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugAppContainer=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.descriptor.munger=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.descriptor.merge=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugLibraries=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugClassRedef=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

######################################################################

### classloading

### verbose
JAVA_OPTIONS="${JAVA_OPTIONS} -verbose:class"
export JAVA_OPTIONS

### 12.1.2 and earlier
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.utils.classloaders.GenericClassLoader.Verbose=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.utils.classloaders.FilteringClassLoader.Verbose=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.utils.classloaders.ChangeAwareClassLoader.Verbose=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

### 12.1.3 and later
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugClassLoadingVerbose=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugClassLoadingContextualTrace=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

######################################################################

### jta

### xa
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTA2PC=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAXA=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAJDBC=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS
### JDBCXADebugLevel=20         # connection pool properties (admin console)

### non-xa
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTANonXA=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJTAJDBC=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.log.StdoutSeverity=Debug"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS
### JDBCXADebugLevel=20         # connection pool properties (admin console)

######################################################################

### jms

### pending message
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSBackEnd=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSFrontEnd=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSCommon=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSDispatcher=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

### pending message (transaction)
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSBackEnd=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSFrontEnd=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSCommon=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSDispatcher=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSXA=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

### redelivery problem
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSMessagePath=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.debug.DebugJMSXA=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS

### message bridge
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.Debug.DebugMessagingBridgeStartup=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.Debug.DebugMessagingBridgeRuntime=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.Debug.DebugMessagingBridgeRuntimeVerbose=true"
JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.StdoutDebugEnabled=true"
export JAVA_OPTIONS
