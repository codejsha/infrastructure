#!/usr/bin/env python

from template.python.data import *
from template.python.enumeration import ServerType


# region base


def read_base_data(values):
    base = Base(
        values['base']['user'],
        values['base']['confluentHome'],
        values['base']['javaHome'],
        values['base']['propertiesPath'],
        values['base']['scriptsPath']
    )
    return base


# endregion

# region servers


def read_server_data(values):
    server_dict = {
        ServerType.ZOOKEEPER: read_zookeeper_list(values),
        ServerType.KAFKA: read_kafka_list(values),
        ServerType.SCHEMA_REGISTRY: read_schema_registry_list(values),
        ServerType.KAFKA_CONNECT: read_kafka_connect_list(values),
        ServerType.KAFKA_REST: read_kafka_rest_list(values),
        ServerType.REPLICATOR: read_replicator_list(values),
        ServerType.KSQLDB: read_ksqldb_list(values),
        ServerType.CONTROL_CENTER: read_control_center_list(values)
    }
    return server_dict


def read_zookeeper_list(values):
    server_list = []

    if values.get('zookeeper') is None:
        return server_list

    # default value
    default_client_port = 2181
    default_peer_to_peer_port = '2888:3888'

    # required
    common_stop_file = \
        values['zookeeper']['common']['stopScript']['file']['stop']
    data_dir = \
        values['zookeeper']['common']['param']['dataDir']
    log_dir = \
        values['zookeeper']['common']['param']['logDir']

    # optional
    client_port = \
        values['zookeeper']['common']['param'].get('clientPort', default_client_port)
    peer_to_peer_port = \
        values['zookeeper']['common']['param'].get('peerToPeerPort', default_peer_to_peer_port)

    for server in values['zookeeper']['servers']:
        server_list.append(
            Zookeeper(
                ServerType.ZOOKEEPER,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log'],
                     common_stop_file),
                server['serverId'],
                override_parameter(server, 'dataDir', data_dir),
                override_parameter(server, 'log_dir', log_dir),
                override_parameter(server, 'clientPort', client_port),
                override_parameter(server, 'peerToPeerPort', peer_to_peer_port)
            )
        )
    return server_list


def read_kafka_list(values):
    server_list = []

    if values.get('kafka') is None:
        return server_list

    # default value
    default_listeners = 'PLAINTEXT://0.0.0.0:9092'

    # required
    common_stop_file = \
        values['kafka']['common']['stopScript']['file']['stop']
    data_dir = \
        values['kafka']['common']['param']['dataDir']
    log_dir = \
        values['kafka']['common']['param']['logDir']
    zookeeper_connect = \
        values['kafka']['common']['param']['zookeeperConnect']

    # optional
    listeners = \
        values['kafka']['common']['param'].get('listeners', default_listeners)
    metrics_reporter_bootstrap_servers = \
        values['kafka']['common']['param'].get('metricsReporterBootstrapServers')

    for server in values['kafka']['servers']:
        default_advertised_listeners = f'PLAINTEXT://{server["hostName"]}:9092'

        server_list.append(
            Kafka(
                ServerType.KAFKA,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log'],
                     common_stop_file),
                server['serverId'],
                override_parameter(server, 'dataDir', data_dir),
                override_parameter(server, 'log_dir', log_dir),
                override_parameter(server, 'listeners', listeners),
                server.get('advertisedListeners', default_advertised_listeners),
                override_parameter(server, 'zookeeperConnect', zookeeper_connect),
                override_parameter(server, 'metricsReporterBootstrapServers',
                                   metrics_reporter_bootstrap_servers)
            )
        )
    return server_list


def read_schema_registry_list(values):
    server_list = []

    if values.get('schemaRegistry') is None:
        return server_list

    # default value
    default_listeners = 'PLAINTEXT://0.0.0.0:8081'
    default_topic = '_schemas'

    # required
    common_stop_file = \
        values['schemaRegistry']['common']['stopScript']['file']['stop']
    log_dir = \
        values['schemaRegistry']['common']['param']['logDir']
    bootstrap_servers = \
        values['schemaRegistry']['common']['param']['bootstrapServers']

    # optional
    listeners = \
        values['schemaRegistry']['common']['param'].get('listeners', default_listeners)
    topic = \
        values['schemaRegistry']['common']['param'].get('topic', default_topic)

    for server in values['schemaRegistry']['servers']:
        server_list.append(
            SchemaRegistry(
                ServerType.SCHEMA_REGISTRY,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log'],
                     common_stop_file),
                override_parameter(server, 'log_dir', log_dir),
                override_parameter(server, 'listeners', listeners),
                override_parameter(server, 'bootstrapServers', bootstrap_servers),
                override_parameter(server, 'topic', topic)
            )
        )
    return server_list


def read_kafka_connect_list(values):
    server_list = []

    if values.get('kafkaConnect') is None:
        return server_list

    # default value
    default_config_storage_topic = 'connect-configs'
    default_offset_storage_topic = 'connect-offsets'
    default_status_storage_topic = 'connect-statuses'

    # required
    common_stop_file = \
        values['kafkaConnect']['common']['stopScript']['file']['stop']
    log_dir = \
        values['kafkaConnect']['common']['param']['logDir']
    group_id = \
        values['kafkaConnect']['common']['param']['groupId']
    bootstrap_servers = \
        values['kafkaConnect']['common']['param']['bootstrapServers']
    plugin_path = \
        values['kafkaConnect']['common']['param']['pluginPath']

    # optional
    key_converter_schema_registry_url = \
        values['kafkaConnect']['common']['param'].get('keyConverterSchemaRegistryUrl')
    value_converter_schema_registry_url = \
        values['kafkaConnect']['common']['param'].get('valueConverterSchemaRegistryUrl')
    config_storage_topic = \
        values['kafkaConnect']['common']['param'].get('configStorageTopic', default_config_storage_topic)
    offset_storage_topic = \
        values['kafkaConnect']['common']['param'].get('offsetStorageTopic', default_offset_storage_topic)
    status_storage_topic = \
        values['kafkaConnect']['common']['param'].get('statusStorageTopic', default_status_storage_topic)

    for server in values['kafkaConnect']['servers']:
        server_list.append(
            KafkaConnect(
                ServerType.KAFKA_CONNECT,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log'],
                     common_stop_file),
                override_parameter(server, 'groupId', group_id),
                override_parameter(server, 'logDir', log_dir),
                override_parameter(server, 'bootstrapServers', bootstrap_servers),
                override_parameter(server, 'keyConverterSchemaRegistryUrl',
                                   key_converter_schema_registry_url),
                override_parameter(server, 'valueConverterSchemaRegistryUrl',
                                   value_converter_schema_registry_url),
                override_parameter(server, 'configStorageTopic', config_storage_topic),
                override_parameter(server, 'offsetStorageTopic', offset_storage_topic),
                override_parameter(server, 'statusStorageTopic', status_storage_topic),
                override_parameter(server, 'pluginPath', plugin_path)
            )
        )
    return server_list


def read_replicator_list(values):
    server_list = []

    if values.get('replicator') is None:
        return server_list

    # default value
    default_config_storage_topic = 'connect-configs'
    default_offset_storage_topic = 'connect-offsets'
    default_status_storage_topic = 'connect-statuses'

    # required
    common_stop_file = \
        values['replicator']['common']['stopScript']['file']['stop']
    log_dir = \
        values['replicator']['common']['param']['logDir']
    group_id = \
        values['replicator']['common']['param']['groupId']
    bootstrap_servers = \
        values['replicator']['common']['param']['bootstrapServers']
    plugin_path = \
        values['replicator']['common']['param']['pluginPath']

    # optional
    key_converter_schema_registry_url = \
        values['replicator']['common']['param'].get('keyConverterSchemaRegistryUrl')
    value_converter_schema_registry_url = \
        values['replicator']['common']['param'].get('valueConverterSchemaRegistryUrl')
    config_storage_topic = \
        values['replicator']['common']['param'].get('configStorageTopic', default_config_storage_topic)
    offset_storage_topic = \
        values['replicator']['common']['param'].get('offsetStorageTopic', default_offset_storage_topic)
    status_storage_topic = \
        values['replicator']['common']['param'].get('statusStorageTopic', default_status_storage_topic)

    for server in values['replicator']['servers']:
        server_list.append(
            Replicator(
                ServerType.REPLICATOR,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log'],
                     common_stop_file),
                override_parameter(server, 'groupId', group_id),
                override_parameter(server, 'logDir', log_dir),
                override_parameter(server, 'bootstrapServers', bootstrap_servers),
                override_parameter(server, 'keyConverterSchemaRegistryUrl', key_converter_schema_registry_url),
                override_parameter(server, 'valueConverterSchemaRegistryUrl', value_converter_schema_registry_url),
                override_parameter(server, 'configStorageTopic', config_storage_topic),
                override_parameter(server, 'offsetStorageTopic', offset_storage_topic),
                override_parameter(server, 'statusStorageTopic', status_storage_topic),
                override_parameter(server, 'pluginPath', plugin_path)
            )
        )
    return server_list


def read_kafka_rest_list(values):
    server_list = []

    if values.get('kafkaRest') is None:
        return server_list

    # required
    common_stop_file = \
        values['kafkaRest']['common']['stopScript']['file']['stop']
    log_dir = \
        values['kafkaRest']['common']['param']['logDir']
    bootstrap_servers = \
        values['kafkaRest']['common']['param']['bootstrapServers']

    # optional
    schema_registry_url = \
        values['kafkaRest']['common']['param'].get('schemaRegistryUrl')

    for server in values['kafkaRest']['servers']:
        server_list.append(
            KafkaRest(
                ServerType.KAFKA_REST,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log'],
                     common_stop_file),
                server['serverId'],
                override_parameter(server, 'logDir', log_dir),
                override_parameter(server, 'bootstrapServers', bootstrap_servers),
                override_parameter(server, 'schemaRegistryUrl', schema_registry_url)
            )
        )
    return server_list


def read_ksqldb_list(values):
    server_list = []

    if values.get('ksqlDB') is None:
        return server_list

    # default value
    default_listeners = 'PLAINTEXT://0.0.0.0:8088'

    # required
    common_stop_file = \
        values['ksqlDB']['common']['stopScript']['file']['stop']
    data_dir = \
        values['ksqlDB']['common']['param']['dataDir']
    log_dir = \
        values['ksqlDB']['common']['param']['logDir']
    group_id = \
        values['ksqlDB']['common']['param']['groupId']
    bootstrap_servers = \
        values['ksqlDB']['common']['param']['bootstrapServers']

    # optional
    listeners = \
        values['ksqlDB']['common']['param'].get('listeners', default_listeners)
    schema_registry_url = \
        values['ksqlDB']['common']['param'].get('schemaRegistryUrl')

    for server in values['ksqlDB']['servers']:
        default_advertised_listener = f'PLAINTEXT://{server["hostName"]}:8088'

        server_list.append(
            KsqlDB(
                ServerType.KSQLDB,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log'],
                     common_stop_file),
                override_parameter(server, 'groupId', group_id),
                override_parameter(server, 'dataDir', data_dir),
                override_parameter(server, 'log_dir', log_dir),
                override_parameter(server, 'listeners', listeners),
                server.get('advertisedListener', default_advertised_listener),
                override_parameter(server, 'bootstrapServers', bootstrap_servers),
                override_parameter(server, 'schemaRegistryUrl', schema_registry_url)
            )
        )
    return server_list


def read_control_center_list(values):
    server_list = []

    if values.get('controlCenter') is None:
        return server_list

    # required
    common_stop_file = \
        values['controlCenter']['common']['stopScript']['file']['stop']
    data_dir = \
        values['controlCenter']['common']['param']['dataDir']
    log_dir = \
        values['controlCenter']['common']['param']['logDir']
    bootstrap_servers = \
        values['controlCenter']['common']['param']['bootstrapServers']
    zookeeper_connect = \
        values['controlCenter']['common']['param']['zookeeperConnect']

    # optional
    schema_registry_url = \
        values['controlCenter']['common']['param'].get('schemaRegistryUrl')
    kafka_connect_url = \
        values['controlCenter']['common']['param'].get('kafkaConnectUrl')
    kafka_rest_url = \
        values['controlCenter']['common']['param'].get('kafkaRestUrl')
    ksqldb_url = \
        values['controlCenter']['common']['param'].get('ksqlDBUrl')

    for server in values['controlCenter']['servers']:
        server_list.append(
            ControlCenter(
                ServerType.CONTROL_CENTER,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log'],
                     common_stop_file),
                server['serverId'],
                override_parameter(server, 'dataDir', data_dir),
                override_parameter(server, 'log_dir', log_dir),
                override_parameter(server, 'bootstrapServers', bootstrap_servers),
                override_parameter(server, 'zookeeperConnect', zookeeper_connect),
                override_parameter(server, 'schemaRegistryUrl', schema_registry_url),
                override_parameter(server, 'kafkaConnectUrl', kafka_connect_url),
                override_parameter(server, 'kafkaRestUrl', kafka_rest_url),
                override_parameter(server, 'ksqlDBUrl', ksqldb_url)
            )
        )
    return server_list


# endregion

# region function


def override_parameter(server, param, value):
    if server.get('paramOverride') is None:
        return value
    else:
        return server.get('paramOverride').get(param)

# endregion
