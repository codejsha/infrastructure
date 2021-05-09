#!/usr/bin/env python

from dataclasses import dataclass

from template.python.enumeration import ServerType


# region base


@dataclass
class Base:
    user: str
    confluent_home: str
    java_home: str
    properties_path: str
    scripts_path: str


# endregion

# region servers


@dataclass
class ServerFile:
    properties: any
    start: any
    stop: str
    log: any


@dataclass
class Server:
    server_type: ServerType
    server_name: str
    host_name: str
    ip_address: str
    stop_script: str
    file: ServerFile


@dataclass
class Zookeeper(Server):
    server_id: str
    data_dir: str
    log_dir: str
    client_port: str
    peer_to_peer_port: str
    z_node: str


@dataclass
class Kafka(Server):
    server_id: str
    data_dir: str
    log_dir: str
    listeners: str
    advertised_listeners: str
    zookeeper_connect: str
    metrics_reporter_bootstrap_servers: str


@dataclass
class SchemaRegistry(Server):
    log_dir: str
    listeners: str
    bootstrap_servers: str


@dataclass
class KafkaConnect(Server):
    group_id: str
    log_dir: str
    bootstrap_servers: str
    key_converter_schema_registry_url: str
    value_converter_schema_registry_url: str
    config_storage_topic: str
    offset_storage_topic: str
    status_storage_topic: str
    plugin_path: str


@dataclass
class Replicator(Server):
    group_id: str
    log_dir: str
    bootstrap_servers: str
    key_converter_schema_registry_url: str
    value_converter_schema_registry_url: str
    config_storage_topic: str
    offset_storage_topic: str
    status_storage_topic: str
    plugin_path: str


@dataclass
class KafkaRest(Server):
    server_id: str
    log_dir: str
    bootstrap_servers: str
    schema_registry_url: str


@dataclass
class KsqlDB(Server):
    group_id: str
    data_dir: str
    log_dir: str
    listeners: str
    advertised_listener: str
    bootstrap_servers: str
    schema_registry_url: str


@dataclass
class ControlCenter(Server):
    server_id: str
    data_dir: str
    log_dir: str
    bootstrap_servers: str
    zookeeper_connect: str
    schema_registry_url: str
    kafka_connect_url: str
    kafka_rest_url: str
    ksql_db_url: str

# endregion
