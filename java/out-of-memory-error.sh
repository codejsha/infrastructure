######################################################################

### java.lang.OutOfMemoryError: Java heap space

### class histogram

### live objects
${JAVA_HOME}/bin/jcmd ${PID} GC.class_histogram
${JAVA_HOME}/bin/jmap -histo:live ${PID}

######################################################################

### java.lang.OutOfMemoryError: Metaspace

### gc logging - metaspace monitoring
-XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC -Xloggc:${LOG_DIR}/gc.${SERVER_NAME}.log
-Xlog:gc*=info:file=${LOG_DIR}/gc.${SERVER_NAME}.log:time,pid,tid,level,tags

### class loading/unloading trace
-XX:+TraceClassLoading -XX:+TraceClassUnloading

### classloader statistics
${JAVA_HOME}/bin/jmap -clstats ${PID}

### native memory tracking
-XX:NativeMemoryTracking=summary
-XX:NativeMemoryTracking=detail
${JAVA_HOME}/bin/jcmd ${PID} VM.native_memory

### ConcurrentMarkSweep
-XX:+TraceClassLoading -XX:+TraceClassUnloading

######################################################################

### java.lang.OutOfMemoryError: PermGen space

### gc logging - perm gen monitoring
-XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC -Xloggc:${LOG_DIR}/gc.${SERVER_NAME}.log
-Xlog:gc*=info:file=${LOG_DIR}/gc.${SERVER_NAME}.log:time,pid,tid,level,tags

### class loading/unloading trace
-XX:+TraceClassLoading -XX:+TraceClassUnloading

### perm gen statistics
${JAVA_HOME}/bin/jmap -permstat ${PID}

### ConcurrentMarkSweep
-XX:+TraceClassLoading -XX:+TraceClassUnloading

######################################################################

### java.lang.OutOfMemoryError: GC overhead limit exceeded

### gc logging
-XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC -Xloggc:${LOG_DIR}/gc.${SERVER_NAME}.log
-Xlog:gc*=info:file=${LOG_DIR}/gc.${SERVER_NAME}.log:time,pid,tid,level,tags

### heap dump
-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${LOG_DIR}/dump

######################################################################

### java.lang.OutOfMemoryError: unable to create new native thread