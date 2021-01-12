######################################################################

### java process
${JAVA_HOME}/bin/jcmd
${JAVA_HOME}/bin/jcmd -l

### version
${JAVA_HOME}/bin/jcmd ${PID} VM.version

### uptime
${JAVA_HOME}/bin/jcmd ${PID} VM.uptime
${JAVA_HOME}/bin/jcmd ${PID} VM.uptime -date

######################################################################

### System Properties
${JAVA_HOME}/bin/jcmd ${PID} VM.system_properties

### VM Flags
${JAVA_HOME}/bin/jcmd ${PID} VM.flags
### VM Flags - PrintFlagsFinal
${JAVA_HOME}/bin/jcmd ${PID} VM.flags -all

### VM Arguments
${JAVA_HOME}/bin/jcmd ${PID} VM.command_line

### System Properties, VM Flags, VM Arguments
${JAVA_HOME}/bin/jinfo ${PID}

######################################################################

### heap dump

### live objects
${JAVA_HOME}/bin/jcmd ${PID} GC.heap_dump ${PID}-heapdump.hprof
${JAVA_HOME}/bin/jmap -dump:live,format=b,file=${PID}-heapdump.hprof ${PID}

### all objects
${JAVA_HOME}/bin/jcmd ${PID} GC.heap_dump -all ${PID}-heapdump.hprof
${JAVA_HOME}/bin/jmap -dump:format=b,file=${PID}-heapdump.hprof ${PID}

######################################################################

### thread dump
${JAVA_HOME}/bin/jcmd ${PID} Thread.print
${JAVA_HOME}/bin/jcmd ${PID} Thread.print > ${PID}-threaddump.tdump
${JAVA_HOME}/bin/jstack -l ${PID}
${JAVA_HOME}/bin/jstack -l ${PID} > ${PID}-threaddump.tdump

######################################################################

### class histogram

### live objects
${JAVA_HOME}/bin/jcmd ${PID} GC.class_histogram
${JAVA_HOME}/bin/jmap -histo:live ${PID}

### all objects
${JAVA_HOME}/bin/jcmd ${PID} GC.class_histogram -all
${JAVA_HOME}/bin/jmap -histo ${PID}

######################################################################

### class stats (jdk8 and later)
JAVA_OPTIONS="${JAVA_OPTIONS} -XX:+UnlockDiagnosticVMOptions"

${JAVA_HOME}/bin/jcmd ${PID} GC.class_stats
${JAVA_HOME}/bin/jcmd ${PID} GC.class_stats -all

######################################################################

### native memory (jdk8 and later)

### summary
JAVA_OPTIONS="${JAVA_OPTIONS} -XX:NativeMemoryTracking=summary"

${JAVA_HOME}/bin/jcmd ${PID} VM.native_memory summary
${JAVA_HOME}/bin/jcmd ${PID} VM.native_memory summary scale=MB

### detail
JAVA_OPTIONS="${JAVA_OPTIONS} -XX:NativeMemoryTracking=detail"

${JAVA_HOME}/bin/jcmd ${PID} VM.native_memory detail
${JAVA_HOME}/bin/jcmd ${PID} VM.native_memory detail scale=MB

######################################################################

### class hierarchy (jdk11 and later)

${JAVA_HOME}/bin/jcmd ${PID} VM.class_hierarchy

### include inherited interfaces
${JAVA_HOME}/bin/jcmd ${PID} VM.class_hierarchy ${CLASSNAME} -i

### include subclasses
${JAVA_HOME}/bin/jcmd ${PID} VM.class_hierarchy ${CLASSNAME} -s

### include inherited interfaces and subclasses
${JAVA_HOME}/bin/jcmd ${PID} VM.class_hierarchy ${CLASSNAME} -i -s
