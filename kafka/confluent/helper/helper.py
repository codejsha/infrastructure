#!/usr/bin/env python

import pathlib

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
        edited_prop = replace_param('schema.registry.group.id', f'{server.group_id}', edited_prop)
        edited_prop = replace_param('host.name', f'{server.host_name}', edited_prop)
        edited_prop = replace_param('listeners', f'{server.listeners}', edited_prop)
        edited_prop = replace_param('kafkastore.bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)

    # kafka-connect
    elif server.server_type == ServerType.KAFKA_CONNECT:
        edited_prop = replace_param('group.id', f'{server.group_id}', edited_prop)
        edited_prop = replace_param('rest.host.name', f'{server.listen_address}', edited_prop)
        edited_prop = replace_param('rest.port', f'{server.listen_port}', edited_prop)
        edited_prop = replace_param('rest.advertised.host.name', f'{server.advertised_listen_address}', edited_prop)
        edited_prop = replace_param('rest.advertised.port', f'{server.advertised_listen_port}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('key.converter.schema.registry.url',
                                    f'{server.key_converter_schema_registry_url}', edited_prop)
        edited_prop = replace_param('value.converter.schema.registry.url',
                                    f'{server.value_converter_schema_registry_url}', edited_prop)
        edited_prop = replace_param('config.storage.topic', f'{server.config_storage_topic}', edited_prop)
        edited_prop = replace_param('offset.storage.topic', f'{server.offset_storage_topic}', edited_prop)
        edited_prop = replace_param('status.storage.topic', f'{server.status_storage_topic}', edited_prop)
        edited_prop = replace_param('plugin.path', f'{server.plugin_path}', edited_prop)

    # replicator
    elif server.server_type == ServerType.REPLICATOR:
        edited_prop = replace_param('group.id', f'{server.group_id}', edited_prop)
        edited_prop = replace_param('rest.host.name', f'{server.listen_address}', edited_prop)
        edited_prop = replace_param('rest.port', f'{server.listen_port}', edited_prop)
        edited_prop = replace_param('rest.advertised.host.name', f'{server.advertised_listen_address}', edited_prop)
        edited_prop = replace_param('rest.advertised.port', f'{server.advertised_listen_port}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('key.converter.schema.registry.url',
                                    f'{server.key_converter_schema_registry_url}', edited_prop)
        edited_prop = replace_param('value.converter.schema.registry.url',
                                    f'{server.value_converter_schema_registry_url}', edited_prop)
        edited_prop = replace_param('config.storage.topic', f'{server.config_storage_topic}', edited_prop)
        edited_prop = replace_param('offset.storage.topic', f'{server.offset_storage_topic}', edited_prop)
        edited_prop = replace_param('status.storage.topic', f'{server.status_storage_topic}', edited_prop)
        edited_prop = replace_param('plugin.path', f'{server.plugin_path}', edited_prop)

    # kafka-rest
    elif server.server_type == ServerType.KAFKA_REST:
        edited_prop = replace_param('id', f'{server.server_id}', edited_prop)
        edited_prop = replace_param('listeners', f'{server.listeners}', edited_prop)
        edited_prop = replace_param('advertised.listeners', f'{server.advertised_listeners}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('schema.registry.url', f'{server.schema_registry_url}', edited_prop)

    # ksqldb
    elif server.server_type == ServerType.KSQLDB:
        edited_prop = replace_param('ksql.service.id', f'{server.group_id}', edited_prop)
        edited_prop = replace_param('ksql.streams.state.dir', f'{server.data_dir}', edited_prop)
        edited_prop = replace_param('listeners', f'{server.listeners}', edited_prop)
        edited_prop = replace_param('ksql.advertised.listener', f'{server.advertised_listener}', edited_prop)
        edited_prop = replace_param('ksql.streams.bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('ksql.schema.registry.url', f'{server.schema_registry_url}', edited_prop)

    write_file(f'output/properties/{server.file.properties}', edited_prop)


def create_control_center_prop_file(server, prop, connect_servers, replicator_servers, ksqldb_servers):
    edited_prop = prop

    # control-center
    if server.server_type == ServerType.CONTROL_CENTER:
        edited_prop = replace_param('confluent.controlcenter.id', f'{server.server_id}', edited_prop)
        edited_prop = replace_param('confluent.controlcenter.data.dir', f'{server.data_dir}', edited_prop)
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
        edited_prop = replace_param('zookeeper.connect', f'{server.zookeeper_connect}', edited_prop)
        edited_prop = replace_param('confluent.controlcenter.schema.registry.url',
                                    f'{server.schema_registry_url}', edited_prop)

        # kafka-connect and replicator clusters
        connect_dict = get_sub_cluster_domain_url_dict(connect_servers)
        replicator_dict = get_sub_cluster_domain_url_dict(replicator_servers)

        connect_and_replicator_dict = {**replicator_dict, **connect_dict}
        for gid, cluster_url in connect_and_replicator_dict.items():
            edited_prop = append_param(f'confluent.controlcenter.connect.{gid}.cluster',
                                       f'confluent.controlcenter.connect.<name>.cluster',
                                       f'{cluster_url}', edited_prop)

        # kafka-rest cluster
        edited_prop = replace_param('confluent.controlcenter.streams.cprest.url',
                                    f'{server.kafka_rest_url}', edited_prop)

        # ksqldb clusters
        ksqldb_domain_dict = get_sub_cluster_domain_url_dict(ksqldb_servers)
        ksqldb_address_dict = get_sub_cluster_address_url_dict(ksqldb_servers)
        for gid, cluster_url in ksqldb_address_dict.items():
            edited_prop = append_param(f'confluent.controlcenter.ksql.{gid}.advertised.url',
                                       f'confluent.controlcenter.ksql.<name>.advertised.url',
                                       f'{cluster_url}', edited_prop)
        for gid, cluster_url in ksqldb_domain_dict.items():
            edited_prop = append_param(f'confluent.controlcenter.ksql.{gid}.url',
                                       f'confluent.controlcenter.ksql.<name>.advertised.url',
                                       f'{cluster_url}', edited_prop)

    write_file(f'output/properties/{server.file.properties}', edited_prop)


def create_start_script_file(base, server, start):
    edited_start = start
    edited_start = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_start)
    edited_start = replace_variable('SERVER_NAME', f'{server.server_name}', edited_start)
    edited_start = replace_variable('PROPERTIES_FILE',
                                    f'{base.properties_path}/{server.file.properties}', edited_start)
    edited_start = replace_variable('LOG_DIR', f'{server.log_dir}', edited_start)
    edited_start = replace_variable('JAVA_HOME', f'{base.java_home}', edited_start)

    if server.server_type in \
            [ServerType.ZOOKEEPER, ServerType.KAFKA, ServerType.KSQLDB, ServerType.CONTROL_CENTER]:
        edited_start = replace_variable('DATA_DIR', f'{server.data_dir}', edited_start)

    if server.server_type == ServerType.ZOOKEEPER:
        edited_start = replace_variable('MYID', f'{server.server_id}', edited_start)

    write_file(f'output/scripts/{server.file.start}', edited_start)


def create_stop_script_file(base, server, stop):
    edited_stop = stop
    edited_stop = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_stop)
    write_file(f'output/scripts/server-stop/{server.file.stop}', edited_stop)


def create_common_stop_script_file(base, server, stop):
    edited_stop = stop
    edited_stop = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_stop)
    write_file(f'output/scripts/{server.stop_script}', edited_stop)


def create_log_script_file(server, log):
    edited_log = log
    edited_log = replace_variable('SERVER_NAME', f'{server.server_name}', edited_log)
    edited_log = replace_variable('LOG_DIR', f'{server.log_dir}', edited_log)
    write_file(f'output/scripts/server-log/{server.file.log}', edited_log)


def create_grep_script_file(server, grep):
    edited_grep = grep
    edited_grep = replace_variable('SERVER_NAME', f'{server.server_name}', edited_grep)
    edited_grep = replace_variable('LOG_DIR', f'{server.log_dir}', edited_grep)
    write_file(f'output/scripts/server-grep/{server.file.grep}', edited_grep)


def create_more_script_file(server, more):
    edited_more = more
    edited_more = replace_variable('SERVER_NAME', f'{server.server_name}', edited_more)
    edited_more = replace_variable('LOG_DIR', f'{server.log_dir}', edited_more)
    write_file(f'output/scripts/server-more/{server.file.more}', edited_more)


def create_server_file(base, server_dict, prop_dict, start_dict, stop_dict, log_dict, grep_dict, more_dict):
    for server_type, servers in server_dict.items():
        for server in servers:
            if server.server_type == ServerType.ZOOKEEPER:
                create_prop_file(server, prop_dict.get(ServerType.ZOOKEEPER),
                                 server_dict.get(ServerType.ZOOKEEPER))
            elif server.server_type == ServerType.CONTROL_CENTER:
                create_control_center_prop_file(server, prop_dict.get(ServerType.CONTROL_CENTER),
                                                server_dict.get(ServerType.KAFKA_CONNECT),
                                                server_dict.get(ServerType.REPLICATOR),
                                                server_dict.get(ServerType.KSQLDB))
            else:
                create_prop_file(server, prop_dict.get(server_type))

            create_start_script_file(base, server, start_dict.get(server_type))
            create_stop_script_file(base, server, stop_dict.get(server_type))
            create_log_script_file(server, log_dict.get(ServerType.ANY))
            create_grep_script_file(server, grep_dict.get(ServerType.ANY))
            create_more_script_file(server, more_dict.get(ServerType.ANY))

    for server in [servers[0] for servers in server_dict.values() if servers]:
        create_common_stop_script_file(base, server, stop_dict.get(server.server_type))


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


def append_param(param, prev_param, param_value, prop):
    edited_prop = re.sub(f'\n# {prev_param}=.*', f'\n# {prev_param}=\n{param}={param_value}', prop, count=1)
    return edited_prop


def replace_param(param, param_value, prop):
    edited_prop = re.sub(f'\n{param}=.*', f'\n{param}={param_value}', prop, count=1)
    return edited_prop


def replace_variable(variable, variable_value, script):
    edited_prop = re.sub(f'\n{variable}=.*', f'\n{variable}="{variable_value}"', script, count=1)
    return edited_prop


def get_sub_cluster_domain_url_dict(cluster_servers):
    temp_dict = {}
    cluster_dict = {}

    for server in cluster_servers:
        if server.group_id in temp_dict:
            temp_dict[f'{server.group_id}'].append(f'http://{server.host_name}:{server.listen_port}')
        else:
            temp_dict[f'{server.group_id}'] = [f'http://{server.host_name}:{server.listen_port}']
    for gid, url in temp_dict.items():
        cluster_dict[gid] = ','.join(url)

    return cluster_dict


def get_sub_cluster_address_url_dict(cluster_servers):
    temp_dict = {}
    cluster_dict = {}

    for server in cluster_servers:
        if server.group_id in temp_dict:
            temp_dict[f'{server.group_id}'].append(f'http://{server.host_address}:{server.listen_port}')
        else:
            temp_dict[f'{server.group_id}'] = [f'http://{server.host_address}:{server.listen_port}']
    for gid, url in temp_dict.items():
        cluster_dict[gid] = ','.join(url)

    return cluster_dict


# endregion


######################################################################


# region main


def main():
    # reset output directory
    current_dir = pathlib.Path(__file__).parent.absolute()
    reset_output_dir(current_dir)

    # read values
    rendered_file_name = render_values_file(f'{current_dir}', 'values.yaml')
    values_data = read_yaml_file(f'{rendered_file_name}')
    base_data = read_base_data(values_data)
    server_data = read_server_data(values_data)

    # read templates
    prop_data = read_prop_template_data(current_dir)
    start_data = read_start_template_data(current_dir)
    stop_data = read_stop_template_data(current_dir)
    log_data = read_log_template_data(current_dir)
    grep_data = read_grep_template_data(current_dir)
    more_data = read_more_template_data(current_dir)

    # create script and property files
    create_server_file(base_data, server_data, prop_data, start_data, stop_data, log_data, grep_data, more_data)

    # create other files
    create_start_and_stop_symlink_script_file(server_data)
    create_add_host_script_file(server_data)
    create_secure_copy_script_file(base_data, server_data)
    create_kafka_alias_file(base_data)


if __name__ == "__main__":
    main()

# endregion
