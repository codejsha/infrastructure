#!/usr/bin/env python

log_dir = os.environ['LOG_DIR']

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

managed_server_name = os.environ['MANAGED_SERVER_NAME']


######################################################################


def set_server_datasource_log_config(_log_dir, _server_name):
    cd('/Servers/' + _server_name + '/DataSource/' + _server_name)
    cmo.setRmiJDBCSecurity('Compatibility')
    cd('/Servers/' + _server_name + '/DataSource/' + _server_name + '/DataSourceLogFile/' + _server_name)
    cmo.setFileName(_log_dir + '/' +  _server_name + '/'
                    'datasource.' + _server_name + '.%%yyyy%%%%MM%%%%dd%%_%%HH%%%%mm%%%%ss%%.log')
    # cmo.setFileName('/dev/null')
    cmo.setRotationType('byTime')
    cmo.setRotationTime('00:00')
    cmo.setFileTimeSpan(24)
    cmo.setNumberOfFilesLimited(True)
    cmo.setFileCount(30)
    cmo.setRotateLogOnStartup(False)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

set_server_datasource_log_config(log_dir, managed_server_name)

save()
activate()
exit()
