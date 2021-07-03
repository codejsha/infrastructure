#!/usr/bin/env python

java_home = os.environ['JAVA_HOME']
oracle_home = os.environ['MW_HOME']

admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

managed_server_name = os.environ['MANAGED_SERVER_NAME']
nodemgr_name = os.environ['NODEMGR_NAME']

server_start_java_vendor = os.environ['SERVER_START_JAVA_VENDOR']
server_start_root_dir = os.environ['SERVER_START_ROOT_DIR']
server_start_arguments = os.environ['SERVER_START_ARGUMENTS']
server_start_classpath = os.environ['SERVER_START_CLASSPATH']


######################################################################


def set_server_start_config(_server_name, _nodemgr_name, _java_home, _java_vendor,
                            _bea_home, _root_dir, _arguments, _classpath):
    if (_nodemgr_name and _nodemgr_name.strip()):
        _arguments = _arguments.replace('  ', ' ').strip()
        _classpath_list = [classpath.strip() for classpath in _classpath.split(';')
                           if (classpath and classpath.strip())]
        _classpath_str = ';'.join(_classpath_list)

        cd('/Servers/' + _server_name + '/ServerStart/' + _server_name)
        cmo.setJavaHome(_java_home)
        cmo.setJavaVendor(_java_vendor)
        cmo.setBeaHome(_bea_home)
        cmo.setRootDirectory(_root_dir)
        cmo.setArguments(_arguments)
        cmo.setClassPath(_classpath_str)
        cmo.setUsername(admin_username)
        cmo.setPassword(admin_password)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()
domain_version = cmo.getDomainVersion()

set_server_start_config(managed_server_name, nodemgr_name, java_home, server_start_java_vendor,
                        oracle_home, server_start_root_dir, server_start_arguments, server_start_classpath)

save()
activate()
exit()
