#!/bin/bash

LAG_EXPORTER_HOME="/app/kafka-lag-exporter"

nohup ${LAG_EXPORTER_HOME}/bin/kafka-lag-exporter \
    -Dconfig.file=${LAG_EXPORTER_HOME}/application.conf \
    -Dlogback.configurationFile=${LAG_EXPORTER_HOME}/logback.xml \
    > ${LAG_EXPORTER_HOME}/nohup.kafka-lag-exporter.out 2>&1 &
