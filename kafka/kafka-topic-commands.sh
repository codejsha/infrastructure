######################################################################
### apache kafka
######################################################################

### topic

### create
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --create \
    --topic my-topic \
    --partitions 3 \
    --replication-factor 1

### delete
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --delete

### topic list
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### describe
./kafka-topics.sh \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --describe




######################################################################
### confluent kafka
######################################################################

### topic

### create
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --create \
    --topic my-topic \
    --partitions 3 \
    --replication-factor 1

### delete
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --delete

### topic list
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --list

### describe
./kafka-topics \
    --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 \
    --topic my-topic \
    --describe
