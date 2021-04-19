# WebLogic

## Install

```bash
### pre-install
### 14c, 12c:
bash ./helper.sh
### 11g:
bash ./helper-11g.sh

### install
bash ./install-weblogic.sh
```

## Domain

```bash
### create domain
bash ./create-domain.sh
```

## Logging

### logrotate

- https://www.redhat.com/sysadmin/setting-logrotate
- https://access.redhat.com/solutions/1294

`/etc/logrotate.d/weblogic_base_domain.conf`:

```conf
daily
rotate 4
create
dateext
notifempty
missingok

/usr/local/weblogic/user_projects/domains/base_domain/logs/*.out {
}

/usr/local/weblogic/user_projects/domains/base_domain/logs/*.log {
}
```

### Rotating log file in Windows service

- https://docs.oracle.com/middleware/12213/wls/START/winservice.htm
- https://docs.oracle.com/en/middleware/standalone/weblogic-server/14.1.1.0/start/winservice.html

#### Edit argument

At the end of the wlsvc command, append the following command option:

```cmd
-log:%LOG_PATH%
```

#### Edit stdout log file

by time:

```log
# ROTATION_TYPE = TIME
# TIME_START_DATE = MONTH DAY YEAR HOUR:MINUTES:SECONDS
# TIME_INTERVAL_MINS = NUMBER_OF_MINUTES
```

by size:

```log
# ROTATION_TYPE = SIZE
# SIZE_KB = FILE_SIZE_IN_KILOBYTES
# SIZE_TRIGGER_INTERVAL_MINS = NUMBER_OF_MINUTES
```

## Deployment

### Deployment descriptor

web.xml:

- https://cloud.google.com/appengine/docs/standard/java/config/webxml
- https://docs.spring.io/spring/docs/current/spring-framework-reference/core.html
- https://docs.oracle.com/middleware/12213/wls/WBAPP/web_xml.htm
- https://docs.oracle.com/middleware/12213/wls/WBAPP/app_events.htm

weblogic.xml:

- https://docs.oracle.com/middleware/12213/wls/WBAPP/weblogic_xml.htm

## WebLogic Plugin

### Check plugin version

#### DebugConfigInfo

Enable the query parameter:

```conf
DebugConfigInfo ON
```

Invoke:

```txt
http://www.example.com/helloworld?__WebLogicBridgeConfig
```

#### Linux

```bash
strings mod_wl.so | grep WLSPLUGINS
# WLSPLUGINS_12.2.1.3.0_LINUX.X64_170817.1846
# WebLogic Server Plugin version 12.2.1.3.0 <WLSPLUGINS_12.2.1.3.0_LINUX.X64_170817.1846>

# WLSPLUGINS_12.1.3.0.0_LINUX.X64_140429.1732
# WebLogic Server Plugin version 12.1.3 <WLSPLUGINS_12.1.3.0.0_LINUX.X64_140429.1732>

# WLSPLUGINS_11.1.1.9.0_LINUX.X64_150206.1116
# WebLogic Server Plugin version 1.1 <WLSPLUGINS_11.1.1.9.0_LINUX.X64_150206.1116>
```

#### Windows

Use Sysinternals strings:

```powershell
strings64.exe iisproxy.dll | Select-String "WLSPLUGINS" -SimpleMatch
# WLSPLUGINS_12.2.1.3.0_WINDOWS.X64_170817.2030
# WebLogic Server Plugin version 12.2.1.3.0 <WLSPLUGINS_12.2.1.3.0_WINDOWS.X64_170817.2030>

# WLSPLUGINS_12.1.3.0.0_WINDOWS.X64_140429.1806
# WebLogic Server Plugin version 12.1.3 <WLSPLUGINS_12.1.3.0.0_WINDOWS.X64_140429.1806>

# WLSPLUGINS_11.1.1.9.0_WINDOWS.X64_150209.1021
# WebLogic Server Plugin version 1.1 <WLSPLUGINS_11.1.1.9.0_WINDOWS.X64_150209.1021>
```

## RESTful Management Services

- https://docs.oracle.com/en/middleware/standalone/weblogic-server/14.1.1.0/wlrur/overview.html
- https://docs.oracle.com/en/middleware/standalone/weblogic-server/14.1.1.0/wlrur/examples.html
- https://docs.oracle.com/en/middleware/fusion-middleware/weblogic-server/12.2.1.4/wlrur/overview.html
- https://docs.oracle.com/en/middleware/fusion-middleware/weblogic-server/12.2.1.4/wlrur/examples.html
- https://docs.oracle.com/middleware/12213/wls/WLRUR/overview.htm
- https://docs.oracle.com/middleware/12213/wls/WLRUR/examples.htm
- https://docs.oracle.com/middleware/11119/wls/RESTS/restfulmanagementservices.htm

## WLST (WebLogic Scripting Tool)

### Set urandom

```bash
export CONFIG_JVM_ARGS="${CONFIG_JVM_ARGS} -Djava.security.egd=file:///dev/urandom"
```

### Connect WLST

```py
admin_server_listen_address = 'test.example.com'
admin_server_listen_port = '7001'
admin_username = 'weblogic'
admin_password = 'welcome1'

admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
```

### Status

#### Server

```bash
### 14c, 12c
${ORACLE_HOME}/oracle_common/common/bin/wlst.sh get_server_status.py
### 11g
${MW_HOME}/wlserver_10.3/common/bin/wlst.sh get_server_status.py
```

```txt
ServerName           State      ListenAddress                       ListenPort
------------------------------------------------------------------------------
AdminServer          RUNNING    test.example.com/192.168.137.150          7001
ManagedServer1       RUNNING    test.example.com/192.168.137.150          7003
ManagedServer2       RUNNING    test.example.com/192.168.137.150          7004


HEAP                          |     AdminServer  ManagedServer1  ManagedServer2
-------------------------------------------------------------------------------
HeapSizeMax                   |      1023410176      1023410176      1023410176
HeapSizeCurrent               |      1023410176      1023410176      1023410176
HeapFreeCurrent               |       626085560       811488576       794110248
HeapFreePercent               |              61              79              77


THREADPOOL                    |     AdminServer  ManagedServer1  ManagedServer2
-------------------------------------------------------------------------------
CompletedRequestCount         |            2849            2436            2415
ExecuteThreadIdleCount        |             149             148             148
ExecuteThreadTotalCount       |             150             150             150
HoggingThreadCount            |               0               1               1
MinThreadsConstraintsCompleted|               0               1               1
MinThreadsConstraintsPending  |               0               0               0
PendingUserRequestCount       |               0               0               0
QueueLength                   |               0               0               0
SharedCapacityForWorkManagers |           65536           65536           65536
StandbyThreadCount            |               0               0               0
Throughput                    |          1.9990          3.9980          4.4843
Suspended                     |           False           False           False
OverloadRejectedRequestsCount |               0               0               0
StuckThreadCount              |               0               0               0
```

#### Datasource

```bash
### 14c, 12c
${ORACLE_HOME}/oracle_common/common/bin/wlst.sh get_datasource_status.py
### 11g
${MW_HOME}/wlserver_10.3/common/bin/wlst.sh get_datasource_status.py
```

```txt
DATASOURCE                       |            ManagedServer1            ManagedServer2
                                 |           BaseDataSource1           BaseDataSource1
--------------------------------------------------------------------------------------
ActiveConnectionsAverageCount    |                         0                         0
ActiveConnectionsCurrentCount    |                         0                         0
ActiveConnectionsHighCount       |                         0                         0
ConnectionDelayTime              |                       276                       291
ConnectionsTotalCount            |                         1                         1
CurrCapacity                     |                         1                         1
CurrCapacityHighCount            |                         1                         1
DeploymentState                  |                         2                         2
FailedReserveRequestCount        |                         0                         0
FailuresToReconnectCount         |                         0                         0
HighestNumAvailable              |                         1                         1
HighestNumUnavailable            |                         0                         0
LeakedConnectionCount            |                         0                         0
ModuleId                         |           BaseDataSource1           BaseDataSource1
Name                             |           BaseDataSource1           BaseDataSource1
NumAvailable                     |                         1                         1
NumUnavailable                   |                         0                         0
PrepStmtCacheAccessCount         |                         0                         0
PrepStmtCacheAddCount            |                         0                         0
PrepStmtCacheCurrentSize         |                         0                         0
PrepStmtCacheDeleteCount         |                         0                         0
PrepStmtCacheHitCount            |                         0                         0
PrepStmtCacheMissCount           |                         0                         0
Properties                       |             {user=system}             {user=system}
ReserveRequestCount              |                         0                         0
State                            |                   Running                   Running
Type                             |     JDBCDataSourceRuntime     JDBCDataSourceRuntime
VersionJDBCDriver                |  oracle.jdbc.OracleDriver  oracle.jdbc.OracleDriver
WaitingForConnectionCurrentCount |                         0                         0
WaitingForConnectionFailureTotal |                         0                         0
WaitingForConnectionHighCount    |                         0                         0
WaitingForConnectionSuccessTotal |                         0                         0
WaitingForConnectionTotal        |                         0                         0
WaitSecondsHighCount             |                         0                         0
```

## Sample application

### 11g

Add `WebLogic Server/Server Examples` component to COMPONENT_PATHS in `silent.xml`.

```xml
        <data-value name="COMPONENT_PATHS" value="WebLogic Server/Core Application Server|WebLogic Server/Administration Console|WebLogic Server/Configuration Wizard and Upgrade Framework|WebLogic Server/Web 2.0 HTTP Pub-Sub Server|WebLogic Server/WebLogic JDBC Drivers|WebLogic Server/Third Party JDBC Drivers|WebLogic Server/WebLogic Server Clients|WebLogic Server/WebLogic Web Server Plugins|WebLogic Server/UDDI and Xquery Support|WebLogic Server/Server Examples" />
```

And then, install weblogic.

```bash
bash ./install-weblogic.sh
```

For convenience, add symbolic links.

```bash
# ln -snf ${DOMAIN_HOME} ${MW_HOME}/${DOMAIN_NAME}

MW_HOME="/usr/local/weblogic"
ln -snf ${MW_HOME}/wlserver_10.3/samples/domains/wl_server ${MW_HOME}/wl_server
ln -snf ${MW_HOME}/wlserver_10.3/samples/domains/medrec ${MW_HOME}/medrec
ln -snf ${MW_HOME}/wlserver_10.3/samples/domains/medrec-spring ${MW_HOME}/medrec-spring
```
