#!/usr/bin/env python

import re

from template.python.data import *
from template.python.enumeration import ServerType


# region base


def read_base_data(values):
    edited_dict = change_dictionary_key_case(values['base'])
    base = Base(**edited_dict)
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

    component_type = {'serverType': ServerType.ZOOKEEPER}
    common_stop = {'stopScript': values['zookeeper']['common']['stopScript']}
    common_params = values['zookeeper']['common']['param']

    for server in values['zookeeper']['servers']:
        edited_dict = transform_dictionary(component_type, common_stop, common_params, server)
        server_list.append(Zookeeper(**edited_dict))

    return server_list


def read_kafka_list(values):
    server_list = []

    if values.get('kafka') is None:
        return server_list

    component_type = {'serverType': ServerType.KAFKA}
    common_stop = {'stopScript': values['kafka']['common']['stopScript']}
    common_params = values['kafka']['common']['param']

    for server in values['kafka']['servers']:
        edited_dict = transform_dictionary(component_type, common_stop, common_params, server)
        server_list.append(Kafka(**edited_dict))

    return server_list


def read_schema_registry_list(values):
    server_list = []

    if values.get('schemaRegistry') is None:
        return server_list

    component_type = {'serverType': ServerType.SCHEMA_REGISTRY}
    common_stop = {'stopScript': values['schemaRegistry']['common']['stopScript']}
    common_params = values['schemaRegistry']['common']['param']

    for server in values['schemaRegistry']['servers']:
        edited_dict = transform_dictionary(component_type, common_stop, common_params, server)
        server_list.append(SchemaRegistry(**edited_dict))

    return server_list


def read_kafka_connect_list(values):
    server_list = []

    if values.get('kafkaConnect') is None:
        return server_list

    component_type = {'serverType': ServerType.KAFKA_CONNECT}
    common_stop = {'stopScript': values['kafkaConnect']['common']['stopScript']}
    common_params = values['kafkaConnect']['common']['param']

    for server in values['kafkaConnect']['servers']:
        edited_dict = transform_dictionary(component_type, common_stop, common_params, server)
        server_list.append(KafkaConnect(**edited_dict))

    return server_list


def read_replicator_list(values):
    server_list = []

    if values.get('replicator') is None:
        return server_list

    component_type = {'serverType': ServerType.REPLICATOR}
    common_stop = {'stopScript': values['replicator']['common']['stopScript']}
    common_params = values['replicator']['common']['param']

    for server in values['replicator']['servers']:
        edited_dict = transform_dictionary(component_type, common_stop, common_params, server)
        server_list.append(Replicator(**edited_dict))

    return server_list


def read_kafka_rest_list(values):
    server_list = []

    if values.get('kafkaRest') is None:
        return server_list

    component_type = {'serverType': ServerType.KAFKA_REST}
    common_stop = {'stopScript': values['kafkaRest']['common']['stopScript']}
    common_params = values['kafkaRest']['common']['param']

    for server in values['kafkaRest']['servers']:
        edited_dict = transform_dictionary(component_type, common_stop, common_params, server)
        server_list.append(KafkaRest(**edited_dict))

    return server_list


def read_ksqldb_list(values):
    server_list = []

    if values.get('ksqlDb') is None:
        return server_list

    component_type = {'serverType': ServerType.KSQLDB}
    common_stop = {'stopScript': values['ksqlDb']['common']['stopScript']}
    common_params = values['ksqlDb']['common']['param']

    for server in values['ksqlDb']['servers']:
        edited_dict = transform_dictionary(component_type, common_stop, common_params, server)
        server_list.append(KsqlDB(**edited_dict))

    return server_list


def read_control_center_list(values):
    server_list = []

    if values.get('controlCenter') is None:
        return server_list

    component_type = {'serverType': ServerType.CONTROL_CENTER}
    common_stop = {'stopScript': values['controlCenter']['common']['stopScript']}
    common_params = values['controlCenter']['common']['param']

    for server in values['controlCenter']['servers']:
        edited_dict = transform_dictionary(component_type, common_stop, common_params, server)
        server_list.append(ControlCenter(**edited_dict))

    return server_list


# endregion

# region function


def transform_dictionary(component_type, common_stop, common_params, server):
    pop_file = server.pop('file')
    server_file = {'file': ServerFile(**pop_file)}
    server_override = server.pop('paramOverride')

    if server_override is not None:
        merge_dict = \
            {**component_type, **common_stop, **common_params, **server, **server_override, **server_file}
    else:
        merge_dict = \
            {**component_type, **common_stop, **common_params, **server, **server_file}

    edited_dict = change_dictionary_key_case(merge_dict)
    return edited_dict


def change_dictionary_key_case(anydict):
    result = dict()
    for key in anydict.keys():
        result[camel_case_to_snake_case(key)] = anydict[key]
    return result


def camel_case_to_snake_case(anystr):
    return re.sub(r"(?<!^)(?=[A-Z])", '_', anystr).lower()

# endregion
