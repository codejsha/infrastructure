######################################################################

### topic

### create topic
./kafka-topics \
    --bootstrap-server kafka1:9092 \
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
    --bootstrap-server kafka1:9092 \
    --topic my-topic \
    --delete
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --delete

### topic list
./kafka-topics \
    --bootstrap-server kafka1:9092 \
    --list
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### describe topic
./kafka-topics \
    --bootstrap-server kafka1:9092 \
    --topic my-topic \
    --describe
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --describe

######################################################################

### producer

### console producer
./kafka-console-producer \
    --bootstrap-server kafka1:9092 \
    --topic my-topic
./kafka-console-producer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic

### console producer (k,v)
./kafka-console-producer \
    --bootstrap-server kafka1:9092 \
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

### console consumer
./kafka-console-consumer \
    --bootstrap-server kafka1:9092 \
    --topic my-topic
./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic

### console consumer (from beginning)
./kafka-console-consumer \
    --bootstrap-server kafka1:9092 \
    --topic my-topic \
    --from-beginning
./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --from-beginning

### console consumer (print key)
./kafka-console-consumer \
    --bootstrap-server kafka1:9092 \
    --property print.key=true \
    --topic my-topic
./kafka-console-consumer \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --property print.key=true \
    --topic my-topic

### consumer group list
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092 \
    --list
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### consumer group desc
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092 \
    --describe \
    --group my-group
./kafka-consumer-groups \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --describe \
    --group my-group

######################################################################

### broker

### broker version
./kafka-broker-api-versions \
    --bootstrap-server kafka1:9092 \
    --version
./kafka-broker-api-versions \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --version

######################################################################

### zookeeper

### broker list
./zookeeper-shell zookeeper1:2181 ls /brokers/ids
./zookeeper-shell zookeeper1:2181,zookeeper2:2181,zookeeper3:2181 ls /brokers/ids

kubectl exec -it my-cluster-zookeeper-0 -- bin/zookeeper-shell localhost:12181 ls /brokers/ids
