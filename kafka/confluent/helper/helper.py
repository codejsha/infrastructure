#!/usr/bin/env python

import pathlib
import re

from template.python.other import *
from template.python.read_template import *
from template.python.read_value import *


# region create_file


def create_prop_file(server, prop, servers=None):
    edited_prop = prop

    # zookeeper
    if server.server_type == ServerType.ZOOKEEPER:
        server_id = server.server_id
        edited_prop = replace_param('dataDir', f'{server.data_dir}', edited_prop)
        edited_prop = replace_param('clientPort', f'{server.client_port}', edited_prop)
        cluster_list = generate_zookeeper_cluster_list(server_id, servers)
        edited_prop = f'{edited_prop}\n' + '\n'.join(cluster_list) + '\n'

    # kafka
    elif server.server_type == ServerType.KAFKA:
        edited_prop = replace_param('broker.id', f'{server.server_id}', edited_prop)
        edited_prop = replace_param('log.dirs', f'{server.data_dir}', edited_prop)
        edited_prop = replace_param('listeners', f'{server.listeners}', edited_prop)
        edited_prop = replace_param('advertised.listeners', f'{server.advertised_listeners}', edited_prop)
        edited_prop = replace_param('zookeeper.connect', f'{server.zookeeper_connect}', edited_prop)
        edited_prop = replace_param('confluent.metrics.reporter.bootstrap.servers',
                                    f'{server.metrics_reporter_bootstrap_servers}', edited_prop)

    # schema-registry
    elif server.server_type == ServerType.SCHEMA_REGISTRY:
        edited_prop = replace_param('host.name', f'{server.host_name}', edited_prop)
        edited_prop = replace_param('listeners', f'{server.listeners}', edited_prop)
        edited_prop = replace_param('kafkastore.bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('kafkastore.topic', f'{server.topic}', edited_prop)

    # kafka-connect
    elif server.server_type == ServerType.KAFKA_CONNECT:
        edited_prop = replace_param('group.id', f'{server.group_id}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('key.converter.schema.registry.url',
                                    f'{server.key_converter_schema_registry_url}', edited_prop)
        edited_prop = replace_param('value.converter.schema.registry.url',
                                    f'{server.value_converter_schema_registry_url}', edited_prop)
        edited_prop = replace_param('plugin.path', f'{server.plugin_path}', edited_prop)

    # replicator
    elif server.server_type == ServerType.REPLICATOR:
        edited_prop = replace_param('group.id', f'{server.group_id}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('key.converter.schema.registry.url',
                                    f'{server.key_converter_schema_registry_url}', edited_prop)
        edited_prop = replace_param('value.converter.schema.registry.url',
                                    f'{server.value_converter_schema_registry_url}', edited_prop)
        edited_prop = replace_param('plugin.path', f'{server.plugin_path}', edited_prop)

    # kafka-rest
    elif server.server_type == ServerType.KAFKA_REST:
        edited_prop = replace_param('id', f'{server.server_id}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('schema.registry.url', f'{server.schema_registry_url}', edited_prop)

    # ksqldb
    elif server.server_type == ServerType.KSQLDB:
        edited_prop = replace_param('ksql.service.id', f'{server.group_id}', edited_prop)
        edited_prop = replace_param('state.dir', f'{server.data_dir}', edited_prop)
        edited_prop = replace_param('state.dir', f'{server.data_dir}', edited_prop)
        edited_prop = replace_param('listeners', f'{server.listeners}', edited_prop)
        edited_prop = replace_param('advertised.listeners', f'{server.advertised_listeners}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('ksql.schema.registry.url', f'{server.schema_registry_url}', edited_prop)

    # control-center
    elif server.server_type == ServerType.CONTROL_CENTER:
        edited_prop = replace_param('confluent.controlcenter.id', f'{server.server_id}', edited_prop)
        edited_prop = replace_param('confluent.controlcenter.data.dir', f'{server.data_dir}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('zookeeper.connect', f'{server.zookeeper_connect}', edited_prop)
        edited_prop = replace_param('confluent.controlcenter.schema.registry.url',
                                    f'{server.schema_registry_url}', edited_prop)
        edited_prop = replace_param('confluent.controlcenter.connect.cluster',
                                    f'{server.kafka_connect_url}', edited_prop)
        edited_prop = replace_param('confluent.controlcenter.streams.cprest.url',
                                    f'{server.kafka_rest_url}', edited_prop)
        edited_prop = replace_param('confluent.controlcenter.ksql.ksqldb.url',
                                    f'{server.ksqldb_url}', edited_prop)

    write_file(f'properties/{server.file.properties_file}', edited_prop)


def create_start_script_file(base, server, start):
    edited_start = start
    edited_start = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_start)
    edited_start = replace_variable('SERVER_NAME', f'{server.server_name}', edited_start)
    edited_start = replace_variable('PROPERTIES_FILE',
                                    f'{base.properties_path}/{server.file.properties_file}', edited_start)
    edited_start = replace_variable('LOG_DIR', f'{server.log_dir}', edited_start)
    edited_start = replace_variable('JAVA_HOME', f'{base.java_home}', edited_start)

    if server.server_type in \
            [ServerType.ZOOKEEPER, ServerType.KAFKA, ServerType.KSQLDB, ServerType.CONTROL_CENTER]:
        edited_start = replace_variable('DATA_DIR', f'{server.data_dir}', edited_start)

    if server.server_type == ServerType.ZOOKEEPER:
        edited_start = replace_variable('MYID', f'{server.server_id}', edited_start)

    write_file(f'scripts/{server.file.start_file}', edited_start)


def create_stop_script_file(base, server, stop):
    edited_stop = stop
    edited_stop = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_stop)
    if isinstance(server, Common):
        write_file(f'scripts/{server.file.stop_file}', edited_stop)
    else:
        write_file(f'scripts/server-stop/{server.file.stop_file}', edited_stop)


def create_log_script_file(server, log):
    edited_log = log
    edited_log = replace_variable('SERVER_NAME', f'{server.server_name}', edited_log)
    edited_log = replace_variable('LOG_DIR', f'{server.log_dir}', edited_log)
    write_file(f'scripts/server-log/{server.file.log_file}', edited_log)


def create_server_file(base, server_dict, prop_dict, start_dict, stop_dict, log_dict):
    for server_type, servers in server_dict.items():
        for server in servers:
            if server.server_type == ServerType.ZOOKEEPER:
                create_prop_file(server, prop_dict.get(server_type), server_dict.get(server_type))
            else:
                create_prop_file(server, prop_dict.get(server_type))
            create_start_script_file(base, server, start_dict.get(server_type))
            create_stop_script_file(base, server, stop_dict.get(server_type))
            create_log_script_file(server, log_dict.get(ServerType.ANY))


# endregion

# region common


def create_common_stop_script_file(base, common_list, stop_dict):
    for common in common_list:
        create_stop_script_file(base, common, stop_dict.get(common.server_type))


# endregion

# region server_specific


def generate_zookeeper_cluster_list(server_id, servers):
    cluster_list = []
    index = 1
    for server in servers:
        if int(server_id) == index:
            cluster_list.append(f'server.{server_id}='
                                f'0.0.0.0:{server.peer_to_peer_port}')
        else:
            cluster_list.append(f'server.{index}='
                                f'{server.server_name}:{server.peer_to_peer_port}')
        index += 1
    return cluster_list


# endregion

# region function


def replace_param(param, param_value, prop):
    edited_prop = re.sub(f'\n{param}=.*', f'\n{param}={param_value}', prop, count=1)
    return edited_prop


def replace_variable(variable, variable_value, script):
    edited_prop = re.sub(f'\n{variable}=.*', f'\n{variable}="{variable_value}"', script, count=1)
    return edited_prop


# endregion


######################################################################


# region main


def main():
    current_dir = pathlib.Path(__file__).parent.absolute()
    reset_output_dir(current_dir)

    # read values
    values_data = read_yaml_file(f'{current_dir}/values.yaml')
    base_data = read_base_data(values_data)
    common_data = read_common_data(values_data)
    server_data = read_server_data(values_data)

    # read template
    prop_data = read_prop_template_data(current_dir)
    start_data = read_start_template_data(current_dir)
    stop_data = read_stop_template_data(current_dir)
    log_data = read_log_template_data(current_dir)

    # create files
    create_server_file(base_data, server_data, prop_data, start_data, stop_data, log_data)
    create_common_stop_script_file(base_data, common_data, stop_data)

    # create other files
    create_start_and_stop_symlink_script_file(common_data, server_data)
    create_add_host_script_file(server_data)
    create_secure_copy_script_file(base_data, server_data)
    create_kafka_alias_file(base_data)


if __name__ == "__main__":
    main()

# endregion
