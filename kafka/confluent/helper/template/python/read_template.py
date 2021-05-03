#!/usr/bin/env python

from template.python.enumeration import ServerType
from template.python.fileio import *


# region properties


def read_prop_template_data(current_dir):
    properties_template_dir = current_dir.joinpath('template/properties')
    prop_dict = {
        ServerType.ZOOKEEPER: read_file(f'{properties_template_dir}/zookeeper-template.properties'),
        ServerType.KAFKA: read_file(f'{properties_template_dir}/kafka-template.properties'),
        ServerType.SCHEMA_REGISTRY: read_file(f'{properties_template_dir}/schema-registry-template.properties'),
        ServerType.KAFKA_CONNECT: read_file(f'{properties_template_dir}/kafka-connect-template.properties'),
        ServerType.REPLICATOR: read_file(f'{properties_template_dir}/replicator-template.properties'),
        ServerType.KAFKA_REST: read_file(f'{properties_template_dir}/kafka-rest-template.properties'),
        ServerType.KSQLDB: read_file(f'{properties_template_dir}/ksqldb-template.properties'),
        ServerType.CONTROL_CENTER: read_file(f'{properties_template_dir}/control-center-template.properties')
    }
    return prop_dict


# endregion

# region scripts


def read_start_template_data(current_dir):
    scripts_template_dir = current_dir.joinpath('template/scripts')
    start_dict = {
        ServerType.ZOOKEEPER: read_file(f'{scripts_template_dir}/start-zookeeper-template.sh'),
        ServerType.KAFKA: read_file(f'{scripts_template_dir}/start-kafka-template.sh'),
        ServerType.SCHEMA_REGISTRY: read_file(f'{scripts_template_dir}/start-schema-registry-template.sh'),
        ServerType.KAFKA_CONNECT: read_file(f'{scripts_template_dir}/start-kafka-connect-template.sh'),
        ServerType.REPLICATOR: read_file(f'{scripts_template_dir}/start-replicator-template.sh'),
        ServerType.KAFKA_REST: read_file(f'{scripts_template_dir}/start-kafka-rest-template.sh'),
        ServerType.KSQLDB: read_file(f'{scripts_template_dir}/start-ksqldb-template.sh'),
        ServerType.CONTROL_CENTER: read_file(f'{scripts_template_dir}/start-control-center-template.sh')
    }
    return start_dict


def read_stop_template_data(current_dir):
    scripts_template_dir = current_dir.joinpath('template/scripts')
    stop_dict = {
        ServerType.ZOOKEEPER: read_file(f'{scripts_template_dir}/stop-zookeeper-template.sh'),
        ServerType.KAFKA: read_file(f'{scripts_template_dir}/stop-kafka-template.sh'),
        ServerType.SCHEMA_REGISTRY: read_file(f'{scripts_template_dir}/stop-schema-registry-template.sh'),
        ServerType.KAFKA_CONNECT: read_file(f'{scripts_template_dir}/stop-kafka-connect-template.sh'),
        ServerType.REPLICATOR: read_file(f'{scripts_template_dir}/stop-replicator-template.sh'),
        ServerType.KAFKA_REST: read_file(f'{scripts_template_dir}/stop-kafka-rest-template.sh'),
        ServerType.KSQLDB: read_file(f'{scripts_template_dir}/stop-ksqldb-template.sh'),
        ServerType.CONTROL_CENTER: read_file(f'{scripts_template_dir}/stop-control-center-template.sh')
    }
    return stop_dict


def read_log_template_data(current_dir):
    scripts_template_dir = current_dir.joinpath('template/scripts')
    log_dict = {
        ServerType.ANY: read_file(f'{scripts_template_dir}/log-template.sh')
    }
    return log_dict

# endregion
