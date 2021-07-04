#!/usr/bin/env python

from enum import Enum


class ServerType(Enum):
    ZOOKEEPER = 1
    KAFKA = 2
    SCHEMA_REGISTRY = 3
    KAFKA_CONNECT = 4
    REPLICATOR = 5
    KAFKA_REST = 6
    KSQLDB = 7
    CONTROL_CENTER = 8
    ANY = 9
    NONE = 10


class TopicCommandType(Enum):
    CREATE = 1
    DELETE = 2
    DESCRIBE = 3
    LIST = 4
    ANY = 5
    NONE = 6
