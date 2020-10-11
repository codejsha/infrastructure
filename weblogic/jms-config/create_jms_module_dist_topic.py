#!/usr/bin/env python

domain_name = os.environ.get('DOMAIN_NAME')
admin_server_listen_address = os.environ.get('ADMIN_SERVER_LISTEN_ADDRESS')
admin_server_listen_port = os.environ.get('ADMIN_SERVER_LISTEN_PORT')
admin_username = os.environ.get('ADMIN_USERNAME')
admin_password = os.environ.get('ADMIN_PASSWORD')

jmsmodule_name = os.environ.get('JMSMODULE_NAME')
disttopic_name = os.environ.get('DISTTOPIC_NAME')
disttopic_jndi = os.environ.get('DISTTOPIC_JNDI')
subdeploy_name = os.environ.get('SUBDEPLOY_NAME')
subdeploy_target = os.environ.get('SUBDEPLOY_TARGET')


######################################################################


def create_jms_module_dist_topic(_jmsmodule_name, _disttopic_name):
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name)
    if _disttopic_name not in [disttpoic.getName() for disttpoic in cmo.getUniformDistributedTopics()]:
        cmo.createUniformDistributedTopic(_disttopic_name)


def set_jms_module_dist_topic_general_config(_jmsmodule_name, _disttopic_name, _disttopic_jndi,
                                             _subdeploy_name, _subdeploy_target):
    cd('/JMSSystemResources/' + _jmsmodule_name + '/JMSResource/' + _jmsmodule_name +
       '/UniformDistributedTopics/' + _disttopic_name)
    cmo.setJNDIName(_disttopic_jndi)
    cmo.setForwardingPolicy('Replicated')
    if _subdeploy_name != None:
        cmo.setSubDeploymentName(_subdeploy_name)
        cd('/SystemResources/' + _jmsmodule_name + '/SubDeployments/' + _subdeploy_name)
        _objects = []
        for target in _subdeploy_target:
            _target_name = target['name']
            if target in clusters.values():
                _objects.append(ObjectName('com.bea:Name=' + _target_name + ',Type=Cluster'))
            elif target in servers.values():
                _objects.append(ObjectName('com.bea:Name=' + _target_name + ',Type=Server'))
            elif target in jmsservers.values():
                _objects.append(ObjectName('com.bea:Name=' + _target_name + ',Type=JMSServer'))
            else:
                pass
        set('Targets', jarray.array(_objects, ObjectName))
    else:
        cmo.unSet('SubDeploymentName')


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

create_jms_module_dist_topic(jmsmodule_name, disttopic_name)
set_jms_module_dist_topic_general_config(jmsmodule_name, disttopic_name, disttopic_jndi,
                                         subdeploy_name, subdeploy_target)

save()
activate()
exit()
