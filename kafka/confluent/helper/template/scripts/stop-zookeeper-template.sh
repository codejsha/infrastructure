#!/bin/bash

CONFLUENT_HOME=""

# ${CONFLUENT_HOME}/bin/zookeeper-server-stop

pkill -9 -ecf "org\.apache\.zookeeper\.server\.quorum\.QuorumPeerMain"
# pkill -15 -ecf "org\.apache\.zookeeper\.server\.quorum\.QuorumPeerMain"
