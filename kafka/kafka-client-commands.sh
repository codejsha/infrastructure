######################################################################

### topic

### create topic
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --create \
    --topic my-topic \
    --partitions 3 \
    --replication-factor 1

### delete topic
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --delete

### topic list
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### describe topic
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --describe

######################################################################

### producer

### console producer
./kafka-console-producer.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic

######################################################################

### consumer

### console consumer
./kafka-console-consumer.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic

### console consumer (from beginning)
./kafka-console-consumer.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --from-beginning

######################################################################

### broker

### broker version
./kafka-broker-api-versions.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version

### broker list
kubectl exec -it my-cluster-zookeeper-0 -- bin/zookeeper-shell.sh localhost:12181 ls /brokers/ids
