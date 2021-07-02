#!/bin/bash

ELASTICSEARCH_HOME="/usr/local/elasticsearch"

nohup ${ELASTICSEARCH_HOME}/bin/elasticsearch \
    > ${ELASTICSEARCH_HOME}/nohup.elasticsearch.out 2>&1 &
