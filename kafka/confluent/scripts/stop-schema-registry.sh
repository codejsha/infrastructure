#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

# ${CONFLUENT_HOME}/bin/schema-registry-stop

pkill -9 -ecf "io\.confluent\.kafka\.schemaregistry\.rest\.SchemaRegistryMain"
# pkill -15 -ecf "io\.confluent\.kafka\.schemaregistry\.rest\.SchemaRegistryMain"
