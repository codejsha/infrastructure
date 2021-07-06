#!/usr/bin/env python

from template.python.base import Base
from template.python.function import *
from template.python.server import *


# region base


def read_base_data(values):
    edited_dict = change_dictionary_key_case(values['base'])
    base = Base(**edited_dict)
    return base


# endregion

# region servers


def read_server_data(values):
    server_dict = {
        ServerType.ZOOKEEPER: read_server_list(ServerType.ZOOKEEPER, values),
        ServerType.KAFKA: read_server_list(ServerType.KAFKA, values),
        ServerType.SCHEMA_REGISTRY: read_server_list(ServerType.SCHEMA_REGISTRY, values),
        ServerType.KAFKA_CONNECT: read_server_list(ServerType.KAFKA_CONNECT, values),
        ServerType.KAFKA_REST: read_server_list(ServerType.KAFKA_REST, values),
        ServerType.REPLICATOR: read_server_list(ServerType.REPLICATOR, values),
        ServerType.KSQLDB: read_server_list(ServerType.KSQLDB, values),
        ServerType.CONTROL_CENTER: read_server_list(ServerType.CONTROL_CENTER, values)
    }
    return server_dict


def read_server_list(server_type, values):
    server_class = None
    server_type_key = ''
    server_list = []

    if server_type == ServerType.ZOOKEEPER:
        server_class = Zookeeper
        server_type_key = 'zookeeper'
    elif server_type == ServerType.KAFKA:
        server_class = Kafka
        server_type_key = 'kafka'
    elif server_type == ServerType.SCHEMA_REGISTRY:
        server_class = SchemaRegistry
        server_type_key = 'schemaRegistry'
    elif server_type == ServerType.KAFKA_CONNECT:
        server_class = KafkaConnect
        server_type_key = 'kafkaConnect'
    elif server_type == ServerType.REPLICATOR:
        server_class = Replicator
        server_type_key = 'replicator'
    elif server_type == ServerType.KAFKA_REST:
        server_class = KafkaRest
        server_type_key = 'kafkaRest'
    elif server_type == ServerType.KSQLDB:
        server_class = KsqlDB
        server_type_key = 'ksqlDb'
    elif server_type == ServerType.CONTROL_CENTER:
        server_class = ControlCenter
        server_type_key = 'controlCenter'

    if values.get(server_type_key) is None:
        return server_list

    server_type_dict = {'serverType': server_type}
    common_stop_dict = {'stopScript': values[server_type_key]['common']['stopScript']}
    common_param_dict = values[server_type_key]['common']['param']

    for server in values[server_type_key]['servers']:
        edited_dict = transform_dictionary(server_type_dict, common_stop_dict, common_param_dict, server)
        server_list.append(server_class(**edited_dict))

    return server_list


# endregion

# region dictionary


def transform_dictionary(component_type, common_stop, common_params, server):
    popped_file = server.pop('file')
    server_file = {'file': ServerFile(**change_dictionary_key_case(popped_file))}
    server_override = server.pop('paramOverride')

    if server_override is not None:
        merge_dict = \
            {**component_type, **common_stop, **common_params, **server, **server_override, **server_file}
    else:
        merge_dict = \
            {**component_type, **common_stop, **common_params, **server, **server_file}

    edited_dict = change_dictionary_key_case(merge_dict)
    return edited_dict

# endregion
