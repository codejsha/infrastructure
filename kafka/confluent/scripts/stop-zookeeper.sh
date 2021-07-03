#!/bin/bash

CONFLUENT_HOME="/usr/local/confluent"

# ${CONFLUENT_HOME}/bin/zookeeper-server-stop

pkill -9 -ecf "org\.apache\.zookeeper\.server\.quorum\.QuorumPeerMain"
# pkill -9 -ecf "org.apache.zookeeper.server.quorum.QuorumPeerMain"
