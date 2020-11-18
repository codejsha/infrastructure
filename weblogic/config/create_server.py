#!/usr/bin/env python

java_home = os.environ['JAVA_HOME']
oracle_home = os.environ['MW_HOME']
domain_name = os.environ['DOMAIN_NAME']
domain_home = os.environ['DOMAIN_HOME']
log_dir = os.environ['LOG_DIR']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

managed_server_name = os.environ['MANAGED_SERVER_NAME']
managed_server_listen_address = os.environ['MANAGED_SERVER_LISTEN_ADDRESS']
managed_server_listen_port = os.environ['MANAGED_SERVER_LISTEN_PORT']
nodemgr_name = os.environ['NODEMGR_NAME']
cluster_name = os.environ['CLUSTER_NAME']

server_start_java_vendor = os.environ['SERVER_START_JAVA_VENDOR']
server_start_root_dir = os.environ['SERVER_START_ROOT_DIR']
server_start_arguments = os.environ['SERVER_START_ARGUMENTS']
server_start_classpath = os.environ['SERVER_START_CLASSPATH']


######################################################################


def create_server(_server_name):
    cd('/')
    if _server_name not in [server.getName() for server in cmo.getServers()]:
        cmo.createServer(_server_name)


def set_server_general_config(_domain_name, _domain_home, _server_name,
                              _server_listen_address, _server_listen_port,
                              _nodemgr_name, _cluster_name):
    cd('/Servers/' + _server_name)
    cmo.setListenAddress(_server_listen_address)
    cmo.setListenPort(int(_server_listen_port))
    cmo.setStartupMode('RUNNING')
    cmo.setVirtualMachineName(_domain_name + '_' + _server_name)
    cmo.setAdministrationPort(9002)
    cmo.setListenPortEnabled(True)
    cmo.setClasspathServletDisabled(False)
    cmo.setClientCertProxyEnabled(False)
    cmo.setJavaCompiler('javac')
    cmo.setWeblogicPluginEnabled(True)
    if (_nodemgr_name and _nodemgr_name.strip()):
        cmo.setMachine(getMBean('/Machines/' + _nodemgr_name))
    else:
        cmo.setMachine(None)
    if (_cluster_name and _cluster_name.strip()):
        cmo.setCluster(getMBean('/Clusters/' + _cluster_name))
    else:
        cmo.setCluster(None)
    cmo.setStagingMode('nostage')
    cmo.setUploadDirectoryName('./servers/' + _server_name + '/upload')
    cmo.setStagingDirectoryName(_domain_home + '/servers/' + _server_name + '/stage')
    cd('/Servers/' + _server_name + '/ServerDiagnosticConfig/' + _server_name)
    cmo.setWLDFDiagnosticVolume('Low')


def set_server_protocol_config(_server_name):
    cd('/Servers/' + _server_name)
    cmo.setTunnelingEnabled(True)


def set_server_tunning_config(_server_name):
    cd('/Servers/' + _server_name)
    # cmo.setNativeIOEnabled(True)
    # cmo.setThreadPoolPercentSocketReaders(33)
    # cmo.setGatheredWritesEnabled(False)
    # cmo.setScatteredReadsEnabled(False)
    # cmo.setMaxOpenSockCount(-1)
    # cmo.setStuckThreadMaxTime(600)
    # cmo.setStuckThreadTimerInterval(60)
    # cmo.setAcceptBacklog(300)
    # cmo.setLoginTimeoutMillis(5000)
    # cmo.setReverseDNSAllowed(False)
    # cmo.setManagedServerIndependenceEnabled(True)
    cmo.setSelfTuningThreadPoolSizeMin(50)
    cmo.setSelfTuningThreadPoolSizeMax(400)
    # cmo.setPeriodLength(60000)
    # cmo.setIdlePeriodsUntilTimeout(4)
    # cmo.setDGCIdlePeriodsUntilTimeout(5)
    # cmo.setMuxerClass('weblogic.socket.NIOSocketMuxer')
    # cmo.setUseConcurrentQueueForRequestManager(False)


def set_server_ssl_config(_server_name):
    cd('/Servers/' + _server_name + '/SSL/' + _server_name)
    cmo.setEnabled(False)
    # cmo.setLoginTimeoutMillis(25000)


def set_server_log_config(_domain_version, _log_dir, _server_name):
    cd('/Servers/' + _server_name + '/Log/' + _server_name)
    cmo.setDateFormatPattern('MMM d, yyyy h:mm:ss,SSS a z')
    # cmo.setFileName(_log_dir + '/' +  _server_name + '/'
    #                 'general_' + _server_name + '_%%yyyy%%%%MM%%%%dd%%_%%HH%%%%mm%%%%ss%%.log')
    cmo.setFileName('/dev/null')
    cmo.setRotationType('byTime')
    cmo.setNumberOfFilesLimited(True)
    cmo.setFileCount(30)
    cmo.setFileTimeSpan(24)
    cmo.setRotationTime('00:00')
    cmo.setRotateLogOnStartup(False)
    cmo.setBufferSizeKB(0)
    cmo.setLoggerSeverity('Info')
    cmo.setLogFileSeverity('Info')
    cmo.setStdoutSeverity('Info')
    cmo.setStdoutFormat('standard')
    cmo.setStdoutLogStack(True)
    cmo.setStacktraceDepth(5)
    cmo.setDomainLogBroadcastSeverity('Info')
    cmo.setRedirectStdoutToServerLogEnabled(True)
    cmo.setRedirectStderrToServerLogEnabled(True)
    cmo.setDomainLogBroadcasterBufferSize(10)
    if ('12.2' in _domain_version) or ('14.' in _domain_version):
        cmo.setLogMonitoringEnabled(True)
        cmo.setLogMonitoringIntervalSecs(30)
        cmo.setLogMonitoringThrottleThreshold(1500)
        cmo.setLogMonitoringThrottleMessageLength(50)
        cmo.setLogMonitoringMaxThrottleMessageSignatureCount(1000)
    elif '12.1' in _domain_version:
        pass
    elif '10.3' in _domain_version:
        cmo.setMemoryBufferSeverity('Info')
    else:
        pass


def set_server_access_log_config(_log_dir, _server_name):
    cd('/Servers/' + _server_name + '/WebServer/' + _server_name + '/WebServerLog/' + _server_name)
    # cmo.setFileName(_log_dir + '/' +  _server_name + '/'
    #                 'access_' + _server_name + '_%%yyyy%%%%MM%%%%dd%%_%%HH%%%%mm%%%%ss%%.log')
    cmo.setFileName('/dev/null')
    cmo.setRotationType('byTime')
    cmo.setNumberOfFilesLimited(True)
    cmo.setFileCount(30)
    cmo.setFileTimeSpan(24)
    cmo.setRotationTime('00:00')
    cmo.setRotateLogOnStartup(False)
    cmo.setBufferSizeKB(0)
    cmo.setLoggingEnabled(True)
    cmo.setELFFields('date time cs-method cs-uri sc-status')
    cmo.setLogFileFormat('common')
    cmo.setLogTimeInGMT(False)


def set_server_datasource_log_config(_log_dir, _server_name):
    cd('/Servers/' + _server_name + '/DataSource/' + _server_name)
    cmo.setRmiJDBCSecurity('Compatibility')
    cd('/Servers/' + _server_name + '/DataSource/' + _server_name + '/DataSourceLogFile/' + _server_name)
    # cmo.setFileName(_log_dir + '/' +  _server_name + '/'
    #                 'datasource_' + _server_name + '_%%yyyy%%%%MM%%%%dd%%_%%HH%%%%mm%%%%ss%%.log')
    cmo.setFileName('/dev/null')
    cmo.setRotationType('byTime')
    cmo.setFileCount(30)
    cmo.setFileTimeSpan(24)
    cmo.setNumberOfFilesLimited(True)
    cmo.setRotationTime('00:00')
    cmo.setRotateLogOnStartup(False)


def set_server_start_config(_server_name, _nodemgr_name, _java_home, _java_vendor,
                            _bea_home, _root_dir, _arguments, _classpath):
    if (_nodemgr_name and _nodemgr_name.strip()):
        cd('/Servers/' + _server_name + '/ServerStart/' + _server_name)
        cmo.setJavaHome(_java_home)
        cmo.setJavaVendor(_java_vendor)
        cmo.setBeaHome(_bea_home)
        cmo.setRootDirectory(_root_dir)
        cmo.setArguments(_arguments)
        cmo.setClassPath(_classpath)
        cmo.setUsername(admin_username)
        cmo.setPassword(admin_password)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

create_server(managed_server_name)
set_server_general_config(domain_name, domain_home, managed_server_name,
                          managed_server_listen_address, managed_server_listen_port,
                          nodemgr_name, cluster_name)
# set_server_protocol_config(server_name)
set_server_tunning_config(managed_server_name)
set_server_ssl_config(managed_server_name)
set_server_log_config(domain_version, log_dir, managed_server_name)
set_server_access_log_config(log_dir, managed_server_name)
# set_server_datasource_log_config(log_dir, server_name)
set_server_start_config(managed_server_name, nodemgr_name, java_home, server_start_java_vendor,
                        oracle_home, server_start_root_dir, server_start_arguments, server_start_classpath)

save()
activate()
exit()
