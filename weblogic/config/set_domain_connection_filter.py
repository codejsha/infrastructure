#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

connection_filter = os.environ['CONNECTION_FILTER']


######################################################################


def set_connection_filter(_domain_name, _conn_filter):
    if (_conn_filter and _conn_filter.strip()):
        _conn_filter_list = [conn_filter.strip() for conn_filter in _conn_filter.split(',')
                             if (conn_filter and conn_filter.strip())]

        cd('/SecurityConfiguration/' + _domain_name)
        cmo.setConnectionLoggerEnabled(True)
        cmo.setConnectionFilter('weblogic.security.net.ConnectionFilterImpl')
        cmo.setConnectionFilterRules(_conn_filter_list)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

set_connection_filter(domain_name, connection_filter)

save()
activate()
exit()
