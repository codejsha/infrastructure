#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
domain_home = os.environ['DOMAIN_HOME']

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

managed_server_name = os.environ['MANAGED_SERVER_NAME']
managed_server_listen_address = os.environ['MANAGED_SERVER_LISTEN_ADDRESS']
managed_server_listen_port = os.environ['MANAGED_SERVER_LISTEN_PORT']
nodemgr_name = os.environ['NODEMGR_NAME']
cluster_name = os.environ['CLUSTER_NAME']


######################################################################


def set_server_config(_domain_name, _domain_home, _server_name,
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


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

set_server_config(domain_name, domain_home, managed_server_name,
                  managed_server_listen_address, managed_server_listen_port,
                  nodemgr_name, cluster_name)

save()
activate()
exit()
