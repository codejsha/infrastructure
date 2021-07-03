#!/usr/bin/env python

log_dir = os.environ['LOG_DIR']

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

managed_server_name = os.environ['MANAGED_SERVER_NAME']


######################################################################


def set_server_log_config(_domain_version, _log_dir, _server_name):
    cd('/Servers/' + _server_name + '/Log/' + _server_name)
    cmo.setFileName(_log_dir + '/' +  _server_name + '/'
                    'general.' + _server_name + '.%%yyyy%%%%MM%%%%dd%%_%%HH%%%%mm%%%%ss%%.log')
    # cmo.setFileName('/dev/null')
    cmo.setRotationType('byTime')
    cmo.setRotationTime('00:00')
    cmo.setFileTimeSpan(24)
    cmo.setNumberOfFilesLimited(True)
    cmo.setFileCount(30)
    cmo.setRotateLogOnStartup(False)
    cmo.setDateFormatPattern('MMM d, yyyy h:mm:ss,SSS a z')
    cmo.setLoggerSeverity('Info')
    cmo.setRedirectStdoutToServerLogEnabled(True)
    cmo.setRedirectStderrToServerLogEnabled(True)
    if ('14.' in _domain_version) or ('12.2' in _domain_version):
        cmo.setLogMonitoringEnabled(True)
        cmo.setLogMonitoringIntervalSecs(30)
        cmo.setLogMonitoringThrottleThreshold(1500)
        cmo.setLogMonitoringThrottleMessageLength(50)
        cmo.setLogMonitoringMaxThrottleMessageSignatureCount(1000)
    cmo.setLogFileSeverity('Info')
    cmo.setBufferSizeKB(0)
    cmo.setStdoutSeverity('Info')
    cmo.setDomainLogBroadcastSeverity('Info')
    cmo.setDomainLogBroadcasterBufferSize(10)
    cmo.setStdoutLogStack(True)
    if '10.3' in _domain_version:
        cmo.setMemoryBufferSeverity('Info')
    cmo.setStacktraceDepth(5)
    cmo.setStdoutFormat('standard')


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

set_server_log_config(domain_version, log_dir, managed_server_name)

save()
activate()
exit()
