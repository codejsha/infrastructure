######################################################################

### topic

### create topic
./kafka-topics \
    --bootstrap-server localhost:9092 \
    --create \
    --topic my-topic \
    --partitions 3 \
    --replication-factor 1
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --create \
    --topic my-topic \
    --partitions 3 \
    --replication-factor 1

### delete topic
./kafka-topics \
    --bootstrap-server localhost:9092 \
    --topic my-topic \
    --delete
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --delete

### topic list
./kafka-topics \
    --bootstrap-server localhost:9092 \
    --list
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### describe topic
./kafka-topics \
    --bootstrap-server localhost:9092 \
    --topic my-topic \
    --describe
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --describe

######################################################################

### producer

### console
./kafka-console-producer \
    --bootstrap-server localhost:9092 \
    --topic my-topic
./kafka-console-producer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic

### console (key,value)
./kafka-console-producer \
    --bootstrap-server localhost:9092 \
    --property parse.key=true \
    --property key.separator=, \
    --topic my-topic
./kafka-console-producer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --property parse.key=true \
    --property key.separator=, \
    --topic my-topic

######################################################################

### consumer

### console
./kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --topic my-topic
./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic

### console (from beginning)
./kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --topic my-topic \
    --from-beginning
./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --from-beginning

### console (print key)
./kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --property print.key=true \
    --topic my-topic
./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --property print.key=true \
    --topic my-topic

### avro
./kafka-avro-console-consumer \
    --bootstrap-server localhost:9092 \
    --property print.key=true \
    --key-deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --topic my-topic

### avro (from beginning)
./kafka-avro-console-consumer \
    --bootstrap-server localhost:9092 \
    --property print.key=true \
    --key-deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --topic my-topic \
    --from-beginning

### consumer group list
./kafka-consumer-groups \
    --bootstrap-server localhost:9092 \
    --list
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### consumer group desc
./kafka-consumer-groups \
    --bootstrap-server localhost:9092 \
    --describe \
    --group my-group
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --describe \
    --group my-group

######################################################################

### zookeeper

### broker list
./zookeeper-shell localhost:2181 ls /brokers/ids
./zookeeper-shell zookeeper1:2181,zookeeper2:2181,zookeeper3:2181 ls /brokers/ids

######################################################################

### broker

### broker version
./kafka-broker-api-versions \
    --bootstrap-server localhost:9092 \
    --version
./kafka-broker-api-versions \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version

######################################################################

### configs

### topics
./kafka-configs \
    --bootstrap-server localhost:9092 \
    --entity-type topics \
    --entity-name my-topic \
    --describe
./kafka-configs \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --entity-type topics \
    --entity-name my-topic \
    --describe

######################################################################

### perf-test

### producer-props
./kafka-producer-perf-test \
    --producer-props \
        bootstrap.servers=localhost:9092 \
        client.id=perf-test-producer \
    --topic perf-test \
    --num-records 1000 \
    --throughput -1 \
    --record-size 500000
./kafka-producer-perf-test \
    --producer-props \
        bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092 \
        client.id=perf-test-producer \
    --topic perf-test \
    --num-records 1000 \
    --throughput -1 \
    --record-size 500000

### producer.properties
./kafka-producer-perf-test \
    --producer.config producer.properties \
    --topic perf-test \
    --num-records 1000 \
    --throughput -1 \
    --record-size 500000

######################################################################

### dump log

./kafka-dump-log \
    --print-data-log \
    --files /tmp/confluent/kafka/data/my-topic-0/00000000000000000000.log
