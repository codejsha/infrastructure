#!/usr/bin/env python

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

ds_name = os.environ['DS_NAME']


######################################################################


def create_generic_datasource(_domain_version, _ds_name):
    cd('/')
    if _ds_name not in [jdbc_resource.getName() for jdbc_resource in cmo.getJDBCSystemResources()]:
        cmo.createJDBCSystemResource(_ds_name)
        cd('/JDBCSystemResources/' + _ds_name + '/JDBCResource/' + _ds_name)
        cmo.setName(_ds_name)
        if ('12.2' in _domain_version) or ('14.' in _domain_version):
            cmo.setDatasourceType('GENERIC')
        cd('/JDBCSystemResources/' + _ds_name + '/JDBCResource/' + _ds_name +
           '/JDBCDriverParams/' + _ds_name + '/Properties/' + _ds_name)
        cmo.createProperty('user')
    else:
        print('[ERROR] The datasource (' + ds_name + ') already exists!')


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

create_generic_datasource(domain_version, ds_name)

save()
activate()
exit()
