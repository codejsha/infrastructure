#!/usr/bin/env python

oracle_home = os.environ['MW_HOME']
domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']


######################################################################


def set_domain_cookie_name(_oracle_home, _domain_version, _domain_name):
    cd('/AdminConsole/' + _domain_name)
    # _prefix = _oracle_home.replace('/', '_').upper()
    _prefix = 'WLS_' + domain_version.replace('.', '').upper()
    _domain_upper = _domain_name.replace('_', '').replace('-', '').upper()
    cmo.setCookieName(_prefix + '_' + _domain_upper + '_SESSION')


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

set_domain_cookie_name(oracle_home, domain_version, domain_name)

save()
activate()
exit()
