#!/usr/bin/env python

from template.python.enumeration import ServerType
from template.python.fileio import write_file
from template.python.function import *


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
        edited_prop = replace_param('bootstrap.servers', f'{server.bootstrap_servers}', edited_prop)
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
        for gid, urls in connect_and_replicator_dict.items():
            edited_prop = append_param(f'confluent.controlcenter.connect.{gid}.cluster', f'{urls}',
                                       f'### kafka-connect', edited_prop)

        # kafka-rest cluster
        edited_prop = replace_param('confluent.controlcenter.streams.cprest.url',
                                    f'{server.kafka_rest_url}', edited_prop)

        # ksqldb clusters
        ksqldb_group_list = get_unique_cluster_list(ksqldb_servers)
        ksqldb_domain_dict = get_sub_cluster_domain_url_dict(ksqldb_servers)
        ksqldb_address_dict = get_sub_cluster_address_url_dict(ksqldb_servers)
        for group in ksqldb_group_list:
            urls = ksqldb_domain_dict.get(group)
            ad_urls = ksqldb_address_dict.get(group)
            edited_prop = append_param(f'confluent.controlcenter.ksql.{group}.advertised.url', f'{ad_urls}',
                                       f'### ksqldb', edited_prop)
            edited_prop = append_param(f'confluent.controlcenter.ksql.{group}.url', f'{urls}',
                                       f'### ksqldb', edited_prop)

    write_file(f'output/properties/{server.file.properties}', edited_prop)
