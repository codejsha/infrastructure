######################################################################
### apache kafka
######################################################################

### topic

### create
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --create \
    --partitions 3 \
    --replication-factor 1 \
    --topic my-topic

### delete
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --delete \
    --topic my-topic

### topic list
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### describe
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --describe \
    --topic my-topic




######################################################################
### confluent kafka
######################################################################

### topic

### create
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --create \
    --partitions 3 \
    --replication-factor 1 \
    --topic my-topic

### delete
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --delete \
    --topic my-topic

### topic list
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### describe
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --describe \
    --topic my-topic
