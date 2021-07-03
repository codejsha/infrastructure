#!/usr/bin/env python

from dataclasses import dataclass

from template.python.enumeration import ServerType


@dataclass
class ServerFile:
    properties: str
    start: str
    stop: str
    log: str
    service: str
    service_env: str


@dataclass
class Server:
    server_type: ServerType
    server_name: str
    host_name: str
    host_address: str
    ssh_port: str
    stop_script: str
    file: ServerFile


@dataclass
class Zookeeper(Server):
    server_id: str
    data_dir: str
    log_dir: str
    client_port: str
    leader_port: str
    leader_election_port: str
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
    group_id: str
    log_dir: str
    listeners: str
    bootstrap_servers: str


@dataclass
class KafkaConnect(Server):
    group_id: str
    log_dir: str
    listen_address: str
    listen_port: str
    advertised_listen_address: str
    advertised_listen_port: str
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
    listen_address: str
    listen_port: str
    advertised_listen_address: str
    advertised_listen_port: str
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
    listeners: str
    advertised_listeners: str
    bootstrap_servers: str
    schema_registry_url: str


@dataclass
class KsqlDB(Server):
    group_id: str
    data_dir: str
    log_dir: str
    listen_port: str
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
    kafka_rest_url: str
