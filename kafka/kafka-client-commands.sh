######################################################################

KAFKA_ADDRESS0="node1.example.com"
KAFKA_ADDRESS1="node2.example.com"
KAFKA_ADDRESS2="node3.example.com"
KAFKA_PORT0="9094"
KAFKA_PORT1="9094"
KAFKA_PORT2="9094"

######################################################################

### topic

### create topic
./kafka-topics.sh \
    --bootstrap-server ${KAFKA_ADDRESS0}:${KAFKA_PORT0},${KAFKA_ADDRESS1}:${KAFKA_PORT1},${KAFKA_ADDRESS2}:${KAFKA_PORT2} \
    --create \
    --topic my-topic2 \
    --partitions 3 \
    --replication-factor 1

### delete topic
./kafka-topics.sh \
    --bootstrap-server ${KAFKA_ADDRESS0}:${KAFKA_PORT0},${KAFKA_ADDRESS1}:${KAFKA_PORT1},${KAFKA_ADDRESS2}:${KAFKA_PORT2} \
    --topic my-topic \
    --delete

### topic list
./kafka-topics.sh \
    --bootstrap-server ${KAFKA_ADDRESS0}:${KAFKA_PORT0},${KAFKA_ADDRESS1}:${KAFKA_PORT1},${KAFKA_ADDRESS2}:${KAFKA_PORT2} \
    --list

### describe topic
./kafka-topics.sh \
    --bootstrap-server ${KAFKA_ADDRESS0}:${KAFKA_PORT0},${KAFKA_ADDRESS1}:${KAFKA_PORT1},${KAFKA_ADDRESS2}:${KAFKA_PORT2} \
    --topic my-topic \
    --describe

######################################################################

### producer

### console producer
./kafka-console-producer.sh \
    --bootstrap-server ${KAFKA_ADDRESS0}:${KAFKA_PORT0},${KAFKA_ADDRESS1}:${KAFKA_PORT1},${KAFKA_ADDRESS2}:${KAFKA_PORT2} \
    --topic my-topic

######################################################################

### consumer

### console consumer
./kafka-console-consumer.sh \
    --bootstrap-server ${KAFKA_ADDRESS0}:${KAFKA_PORT0},${KAFKA_ADDRESS1}:${KAFKA_PORT1},${KAFKA_ADDRESS2}:${KAFKA_PORT2} \
    --topic my-topic

### console consumer (from beginning)
./kafka-console-consumer.sh \
    --bootstrap-server ${KAFKA_ADDRESS0}:${KAFKA_PORT0},${KAFKA_ADDRESS1}:${KAFKA_PORT1},${KAFKA_ADDRESS2}:${KAFKA_PORT2} \
    --topic my-topic \
    --from-beginning

######################################################################

### broker

### broker version
./kafka-broker-api-versions.sh \
    --bootstrap-server ${KAFKA_ADDRESS0}:${KAFKA_PORT0},${KAFKA_ADDRESS1}:${KAFKA_PORT1},${KAFKA_ADDRESS2}:${KAFKA_PORT2} \
    --version

### broker list
kubectl exec -it my-cluster-zookeeper-0 -- bin/zookeeper-shell.sh localhost:12181 ls /brokers/ids
