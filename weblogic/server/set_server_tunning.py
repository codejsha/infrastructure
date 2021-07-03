#!/usr/bin/env python

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

managed_server_name = os.environ['MANAGED_SERVER_NAME']


######################################################################


def set_server_tunning_config(_server_name):
    cd('/Servers/' + _server_name)
    cmo.setNativeIOEnabled(True)
    # cmo.setThreadPoolPercentSocketReaders(33)
    # cmo.setGatheredWritesEnabled(False)
    # cmo.setScatteredReadsEnabled(False)
    # cmo.setMaxOpenSockCount(-1)
    cmo.setStuckThreadMaxTime(600)
    # cmo.setStuckThreadTimerInterval(60)
    cmo.setAcceptBacklog(300)
    # cmo.setLoginTimeoutMillis(5000)
    # cmo.setReverseDNSAllowed(False)
    # cmo.setManagedServerIndependenceEnabled(True)
    cmo.setSelfTuningThreadPoolSizeMin(150)
    cmo.setSelfTuningThreadPoolSizeMax(150)
    # cmo.setPeriodLength(60000)
    # cmo.setIdlePeriodsUntilTimeout(4)
    # cmo.setDGCIdlePeriodsUntilTimeout(5)
    # cmo.setMuxerClass('weblogic.socket.NIOSocketMuxer')
    # cmo.setUseConcurrentQueueForRequestManager(False)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

set_server_tunning_config(managed_server_name)

save()
activate()
exit()
