#!/usr/bin/env python

from template.python.enumeration import ServerType
from template.python.fileio import write_file


def create_log4j_prop_file(server_type, log4j_prop):
    if server_type == ServerType.ZOOKEEPER:
        write_file(f'output/log4j/zookeeper-log4j.properties', log4j_prop)
    elif server_type == ServerType.KAFKA:
        write_file(f'output/log4j/kafka-log4j.properties', log4j_prop)
    elif server_type == ServerType.SCHEMA_REGISTRY:
        write_file(f'output/log4j/schema-registry-log4j.properties', log4j_prop)
    elif server_type == ServerType.KAFKA_CONNECT:
        write_file(f'output/log4j/kafka-connect-log4j.properties', log4j_prop)
    elif server_type == ServerType.REPLICATOR:
        write_file(f'output/log4j/replicator-log4j.properties', log4j_prop)
    elif server_type == ServerType.KAFKA_REST:
        write_file(f'output/log4j/kafka-rest-log4j.properties', log4j_prop)
    elif server_type == ServerType.KSQLDB:
        write_file(f'output/log4j/ksqldb-log4j.properties', log4j_prop)
    elif server_type == ServerType.CONTROL_CENTER:
        write_file(f'output/log4j/control-center-log4j.properties', log4j_prop)
