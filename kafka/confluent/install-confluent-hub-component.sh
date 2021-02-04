#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"
${CONFLUENT_HOME}/bin/confluent-hub install confluentinc/kafka-connect-datagen:0.4.0
