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

# region common


def read_common_data(values):
    common_list = []
    for key in ['zookeeper', 'kafka', 'schemaRegistry',
                'kafkaConnect', 'replicator', 'kafkaRest',
                'ksqlDB', 'controlCenter']:
        server_type = -1
        if key == 'zookeeper':
            server_type = ServerType.ZOOKEEPER
        elif key == 'kafka':
            server_type = ServerType.KAFKA
        elif key == 'schemaRegistry':
            server_type = ServerType.SCHEMA_REGISTRY
        elif key == 'kafkaConnect':
            server_type = ServerType.KAFKA_CONNECT
        elif key == 'replicator':
            server_type = ServerType.REPLICATOR
        elif key == 'kafkaRest':
            server_type = ServerType.KAFKA_REST
        elif key == 'ksqlDB':
            server_type = ServerType.KSQLDB
        elif key == 'controlCenter':
            server_type = ServerType.CONTROL_CENTER

        if values.get(key, None) is not None:
            common_list.append(
                Common(
                    server_type,
                    File(None,
                         None,
                         values[key]['common']['commonStopScript']['file']['stop'],
                         None)
                )
            )
    return common_list


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
    if values.get('zookeeper', None) is None:
        return server_list
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
                     server['file']['log']),
                server['serverId'],
                server['dataDir'],
                server['logDir'],
                server.get('clientPort', None),
                server.get('peerToPeerPort', None)
            )
        )
    return server_list


def read_kafka_list(values):
    server_list = []
    if values.get('kafka', None) is None:
        return server_list
    for server in values['kafka']['servers']:
        server_list.append(
            Kafka(
                ServerType.KAFKA,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log']),
                server.get('serverId', None),
                server['dataDir'],
                server['logDir'],
                server['listeners'],
                server.get('advertisedListeners', None),
                server['zookeeperConnect'],
                server['metricsReporterBootstrapServers']
            )
        )
    return server_list


def read_schema_registry_list(values):
    server_list = []
    if values.get('schemaRegistry', None) is None:
        return server_list
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
                     server['file']['log']),
                server['logDir'],
                server['listeners'],
                server['bootstrapServers'],
                server.get('topic', None)
            )
        )
    return server_list


def read_kafka_connect_list(values):
    server_list = []
    if values.get('kafkaConnect', None) is None:
        return server_list
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
                     server['file']['log']),
                server.get('groupId', None),
                server['logDir'],
                server['bootstrapServers'],
                server.get('keyConverterSchemaRegistryUrl', None),
                server.get('valueConverterSchemaRegistryUrl', None),
                server.get('pluginPath', None)
            )
        )
    return server_list


def read_replicator_list(values):
    server_list = []
    if values.get('replicator', None) is None:
        return server_list
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
                     server['file']['log']),
                server.get('groupId', None),
                server['logDir'],
                server['bootstrapServers'],
                server.get('keyConverterSchemaRegistryUrl', None),
                server.get('valueConverterSchemaRegistryUrl', None),
                server.get('pluginPath', None)
            )
        )
    return server_list


def read_kafka_rest_list(values):
    server_list = []
    if values.get('kafkaRest', None) is None:
        return server_list
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
                     server['file']['log']),
                server.get('serverId', None),
                server['logDir'],
                server['bootstrapServers'],
                server.get('schemaRegistryUrl', None)
            )
        )
    return server_list


def read_ksqldb_list(values):
    server_list = []
    if values.get('ksqlDB', None) is None:
        return server_list
    for server in values['ksqlDB']['servers']:
        server_list.append(
            KsqlDB(
                ServerType.KSQLDB,
                server['serverName'],
                server['hostName'],
                server['ipAddress'],
                File(server['file']['properties'],
                     server['file']['start'],
                     server['file']['stop'],
                     server['file']['log']),
                server.get('groupId', None),
                server['dataDir'],
                server['logDir'],
                server['listeners'],
                server.get('advertisedListener', None),
                server['bootstrapServers'],
                server.get('schemaRegistryUrl', None)
            )
        )
    return server_list


def read_control_center_list(values):
    server_list = []
    if values.get('controlCenter', None) is None:
        return server_list
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
                     server['file']['log']),
                server.get('serverId', None),
                server['dataDir'],
                server['logDir'],
                server['bootstrapServers'],
                server['zookeeperConnect'],
                server.get('schemaRegistryUrl', None),
                server.get('kafkaConnectUrl', None),
                server.get('kafkaRestUrl', None),
                server.get('ksqlDBUrl', None)
            )
        )
    return server_list

# endregion
