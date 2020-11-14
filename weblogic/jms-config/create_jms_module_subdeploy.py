#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

jmsmodule_name = os.environ['JMSMODULE_NAME']
subdeploy_name = os.environ['SUBDEPLOY_NAME']
subdeploy_target = os.environ['SUBDEPLOY_TARGET']
subdeploy_target_type = os.environ['SUBDEPLOY_TARGET_TYPE']


######################################################################


def create_jms_module_subdeploy(_jmsmodule_name, _subdeploy_name):
    cd('/SystemResources/' + _jmsmodule_name)
    if _subdeploy_name not in [subdeploy.getName() for subdeploy in cmo.getSubDeployments()]:
        cmo.createSubDeployment(_subdeploy_name)


def set_jms_module_subdeploy_general_config(_jmsmodule_name, _subdeploy_name, _subdeploy_target,
                                            _subdeploy_target_type):
    cd('/SystemResources/' + _jmsmodule_name + '/SubDeployments/' + _subdeploy_name)
    _target_list = [target.strip() for target in _subdeploy_target.split(',')]
    _objects = []
    for _target_name in _target_list:
        if _subdeploy_target_type == "Cluster":
            _objects.append(ObjectName('com.bea:Name=' + _target_name + ',Type=Cluster'))
        elif _subdeploy_target_type == "Server":
            _objects.append(ObjectName('com.bea:Name=' + _target_name + ',Type=Server'))
        elif _subdeploy_target_type == "JMSServer":
            _objects.append(ObjectName('com.bea:Name=' + _target_name + ',Type=JMSServer'))
        else:
            pass
    set('Targets', jarray.array(_objects, ObjectName))


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

create_jms_module_subdeploy(jmsmodule_name, subdeploy_name)
set_jms_module_subdeploy_general_config(jmsmodule_name, subdeploy_name, subdeploy_target,
                                        subdeploy_target_type)

save()
activate()
exit()
