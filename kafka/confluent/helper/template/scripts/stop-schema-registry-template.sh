#!/bin/bash

CONFLUENT_HOME=""

# ${CONFLUENT_HOME}/bin/schema-registry-stop

pkill -9 -ecf "io\.confluent\.kafka\.schemaregistry\.rest\.SchemaRegistryMain"
# pkill -9 -ecf "io.confluent.kafka.schemaregistry.rest.SchemaRegistryMain"
