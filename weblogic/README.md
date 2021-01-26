# WebLogic

## Install

```bash
### pre-install
bash ./helper.sh

### install
bash ./install-weblogic.sh
```

## Create a domain

```bash
bash ./create-domain.sh
```

## Configuration

- Domain: [config README](/weblogic/config/README.md)
- JMS: [jms-config README](/weblogic/jms-config/README.md)

### Logging

- [Logging](/weblogic/logging/logging.md)
- [debug.sh](/weblogic/debug.sh)

## Deployment descriptor

web.xml:

- https://cloud.google.com/appengine/docs/standard/java/config/webxml
- https://docs.spring.io/spring/docs/current/spring-framework-reference/core.html
- https://docs.oracle.com/middleware/12213/wls/WBAPP/web_xml.htm
- https://docs.oracle.com/middleware/12213/wls/WBAPP/app_events.htm

weblogic.xml:

- https://docs.oracle.com/middleware/12213/wls/WBAPP/weblogic_xml.htm

## RESTful Management Services

- [RESTful Management Services README](/weblogic/restful/README.md)

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
### 11g
${MW_HOME}/wlserver_10.3/common/bin/wlst.sh get_server_status.py
### 12c, 14c
${ORACLE_HOME}/oracle_common/common/bin/wlst.sh get_server_status.py
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
### 11g
${MW_HOME}/wlserver_10.3/common/bin/wlst.sh get_datasource_status.py
### 12c, 14c
${ORACLE_HOME}/oracle_common/common/bin/wlst.sh get_datasource_status.py
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

Add 'WebLogic Server/Server Examples' component to COMPONENT_PATHS in [silent.xml](/weblogic/silent.xml).

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
