#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']


######################################################################


def set_domain_web_app(_domain_name):
    cd('/WebAppContainer/' + _domain_name)
    # cmo.setReloginEnabled(false)
    # cmo.setAllowAllRoles(false)
    # cmo.setFilterDispatchedRequestsEnabled(false)
    # cmo.setOverloadProtectionEnabled(false)
    cmo.setXPoweredByHeaderLevel('NONE')
    # cmo.setMimeMappingFile('./config/mimemappings.properties')
    # cmo.setOptimisticSerialization(false)
    # cmo.setRtexprvalueJspParamName(false)
    # cmo.setClientCertProxyEnabled(false)
    # cmo.setHttpTraceSupportEnabled(false)
    # cmo.setWeblogicPluginEnabled(false)
    # cmo.setAuthCookieEnabled(true)
    # cmo.setChangeSessionIDOnAuthentication(true)
    # cmo.setWAPEnabled(false)
    # cmo.setPostTimeoutSecs(30)
    # cmo.setMaxPostTimeSecs(-1)
    # cmo.setMaxPostSize(-1)
    # cmo.setWorkContextPropagationEnabled(true)
    # cmo.setP3PHeaderValue('')
    # cmo.setJSPCompilerBackwardsCompatible(false)
    # cmo.setShowArchivedRealPathEnabled(false)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

set_domain_web_app(domain_name)

save()
activate()
exit()
