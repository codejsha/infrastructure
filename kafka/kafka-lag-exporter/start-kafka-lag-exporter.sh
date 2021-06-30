#!/bin/bash

LAG_EXPORTER_HOME="/usr/local/kafka-lag-exporter"

JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JAVA_HOME

nohup ${LAG_EXPORTER_HOME}/bin/kafka-lag-exporter \
    -Dconfig.file=${LAG_EXPORTER_HOME}/application.conf \
    -Dlogback.configurationFile=${LAG_EXPORTER_HOME}/logback.xml \
    > ${LAG_EXPORTER_HOME}/nohup.kafka-lag-exporter.out 2>&1 &
