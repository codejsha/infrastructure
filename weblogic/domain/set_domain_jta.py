#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']


######################################################################


def set_domain_jta(_domain_name):
    cd('/JTA/' + _domain_name)
    cmo.setTimeoutSeconds(30)
    # cmo.setAbandonTimeoutSeconds(86400)
    # cmo.setBeforeCompletionIterationLimit(10)
    # cmo.setMaxTransactions(10000)
    # cmo.setMaxUniqueNameStatistics(1000)
    # cmo.setCheckpointIntervalSeconds(300)
    # cmo.setTLOGWriteWhenDeterminerExistsEnabled(false)
    # cmo.unSet('Determiners')
    # cmo.setForgetHeuristics(true)
    # cmo.setUnregisterResourceGracePeriod(30)
    # cmo.setParallelXAEnabled(true)
    # cmo.setTwoPhaseEnabled(true)
    # cmo.setTightlyCoupledTransactionsEnabled(false)
    # cmo.setClusterwideRecoveryEnabled(false)

    # cmo.setSecurityInteropMode('default')
    # cmo.setCompletionTimeoutSeconds(0)
    # cmo.setMaxXACallMillis(120000)
    # cmo.setMaxResourceUnavailableMillis(1800000)
    # cmo.setMaxResourceRequestsOnServer(50)
    # cmo.setWSATTransportSecurityMode('SSLNotRequired')
    # cmo.setWSATIssuedTokenEnabled(false)
    # cmo.setCrossSiteRecoveryRetryInterval(60)
    # cmo.setCrossSiteRecoveryLeaseExpiration(30)
    # cmo.setCrossSiteRecoveryLeaseUpdate(10)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

set_domain_jta(domain_name)

save()
activate()
exit()
