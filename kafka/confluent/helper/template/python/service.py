#!/usr/bin/env python

from template.python.enumeration import ServerType
from template.python.fileio import write_file
from template.python.function import *


def create_service_script_file(base, server, service_script):
    edited_service = service_script
    edited_service = replace_variable('USER', f'{base.user}', edited_service)
    edited_service = replace_variable('GROUP', f'{base.group}', edited_service)
    edited_service = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_service)
    edited_service = replace_variable('SERVER_NAME', f'{server.server_name}', edited_service)
    edited_service = replace_variable('PROPERTIES_FILE',
                                      f'{base.properties_dir}/{server.file.properties}', edited_service)
    edited_service = replace_variable('LOG_DIR', f'{server.log_dir}', edited_service)

    if server.server_type in \
            [ServerType.ZOOKEEPER, ServerType.KAFKA, ServerType.KSQLDB, ServerType.CONTROL_CENTER]:
        edited_service = replace_variable('DATA_DIR', f'{server.data_dir}', edited_service)

    if server.server_type == ServerType.ZOOKEEPER:
        edited_service = replace_variable('MYID', f'{server.server_id}', edited_service)

    edited_service = substitute_variable('USER', f'{base.user}', edited_service)
    edited_service = substitute_variable('GROUP', f'{base.group}', edited_service)
    edited_service = substitute_variable('SERVER_NAME', f'{server.server_name}', edited_service)
    edited_service = substitute_variable('PROPERTIES_FILE',
                                         f'{base.properties_dir}/{server.file.properties}', edited_service)
    edited_service = substitute_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_service)

    write_file(f'output/services/{server.file.service}', edited_service)


def create_service_env_file(base, server, service_env):
    edited_service_env = service_env
    edited_service_env = replace_variable('LOG_DIR', f'{server.log_dir}', edited_service_env)
    edited_service_env = replace_variable('JAVA_HOME', f'{base.java_home}', edited_service_env)

    edited_service_env = substitute_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_service_env)
    edited_service_env = substitute_variable('SERVER_NAME', f'{server.server_name}', edited_service_env)

    write_file(f'output/services/{server.file.service_env}', edited_service_env)
