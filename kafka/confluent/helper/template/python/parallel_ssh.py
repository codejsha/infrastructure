#!/usr/bin/env python

from template.python.enumeration import ServerType
from template.python.fileio import write_file
from template.python.function import *


def create_pssh_host_file(base, server_dict):
    server_type_str = ''

    for server_type, servers in server_dict.items():
        data_list = []

        if server_type == ServerType.ZOOKEEPER:
            server_type_str = 'zookeeper'
        elif server_type == ServerType.KAFKA:
            server_type_str = 'kafka'
        elif server_type == ServerType.SCHEMA_REGISTRY:
            server_type_str = 'schema-registry'
        elif server_type == ServerType.KAFKA_CONNECT:
            server_type_str = 'kafka-connect'
        elif server_type == ServerType.REPLICATOR:
            server_type_str = 'replicator'
        elif server_type == ServerType.KAFKA_REST:
            server_type_str = 'kafka-rest'
        elif server_type == ServerType.KSQLDB:
            server_type_str = 'ksqldb'
        elif server_type == ServerType.CONTROL_CENTER:
            server_type_str = 'control-center'

        data_list.append(f'### {server_type_str}\n')

        for server in servers:
            # data_list.append(f'### {server.server_name}')
            # data_list.append(f'### {server.host_name}')
            data_list.append(f'{base.user}@{server.host_address}:{server.ssh_port}')

        edited_hosts = '\n'.join(data_list) + '\n'
        write_file(f'output/pssh/hosts/{server_type_str}.hosts', edited_hosts)


def create_pssh_start_script_file(base, server_type, start_script):
    edited_start = start_script
    edited_start = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_start)
    edited_start = substitute_variable('SCRIPTS_DIR', f'{base.scripts_dir}', edited_start)

    if server_type == ServerType.ZOOKEEPER:
        write_file(f'output/pssh/start-all-zookeeper.sh', edited_start)
    elif server_type == ServerType.KAFKA:
        write_file(f'output/pssh/start-all-kafka.sh', edited_start)
    elif server_type == ServerType.SCHEMA_REGISTRY:
        write_file(f'output/pssh/start-all-schema-registry.sh', edited_start)
    elif server_type == ServerType.KAFKA_CONNECT:
        write_file(f'output/pssh/start-all-kafka-connect.sh', edited_start)
    elif server_type == ServerType.REPLICATOR:
        write_file(f'output/pssh/start-all-replicator.sh', edited_start)
    elif server_type == ServerType.KAFKA_REST:
        write_file(f'output/pssh/start-all-kafka-rest.sh', edited_start)
    elif server_type == ServerType.KSQLDB:
        write_file(f'output/pssh/start-all-ksqldb.sh', edited_start)
    elif server_type == ServerType.CONTROL_CENTER:
        write_file(f'output/pssh/start-all-control-center.sh', edited_start)


def create_pssh_stop_script_file(base, server_type, stop_script):
    edited_stop = stop_script
    edited_stop = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_stop)
    edited_stop = substitute_variable('SCRIPTS_DIR', f'{base.scripts_dir}', edited_stop)

    if server_type == ServerType.ZOOKEEPER:
        write_file(f'output/pssh/stop-all-zookeeper.sh', edited_stop)
    elif server_type == ServerType.KAFKA:
        write_file(f'output/pssh/stop-all-kafka.sh', edited_stop)
    elif server_type == ServerType.SCHEMA_REGISTRY:
        write_file(f'output/pssh/stop-all-schema-registry.sh', edited_stop)
    elif server_type == ServerType.KAFKA_CONNECT:
        write_file(f'output/pssh/stop-all-kafka-connect.sh', edited_stop)
    elif server_type == ServerType.REPLICATOR:
        write_file(f'output/pssh/stop-all-replicator.sh', edited_stop)
    elif server_type == ServerType.KAFKA_REST:
        write_file(f'output/pssh/stop-all-kafka-rest.sh', edited_stop)
    elif server_type == ServerType.KSQLDB:
        write_file(f'output/pssh/stop-all-ksqldb.sh', edited_stop)
    elif server_type == ServerType.CONTROL_CENTER:
        write_file(f'output/pssh/stop-all-control-center.sh', edited_stop)


def create_pssh_kill_script_file(base, kill_script):
    edited_kill = kill_script
    edited_kill = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_kill)
    write_file(f'output/pssh/kill-java.sh', edited_kill)


def create_pssh_script_file(base, start_dict, stop_dict, kill_dict):
    for server_type, start_script in start_dict.items():
        create_pssh_start_script_file(base, server_type, start_script)
    for server_type, stop_script in stop_dict.items():
        create_pssh_stop_script_file(base, server_type, stop_script)
    for server_type, kill_script in kill_dict.items():
        create_pssh_kill_script_file(base, kill_script)
