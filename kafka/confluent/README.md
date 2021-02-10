# Confluent Kafka

## Install

### Local

```bash
bash ./install-confluent-kafka.sh
```

### Kubernetes

```bash
bash ./helm-install-confluent-kafka.sh
```

## Configuration parameters

### Topic

partition, replication factor

- ⭐ `segment.ms`
- ⭐ `segment.bytes`
- ⭐ `retention.ms`
- ⭐ `retention.bytes`
- ⭐ `max.message.bytes`
- ⭐ `cleanup.policy`
- ⭐ `min.insync.replicas`
- ⭐ `unclean.leader.election.enable`
- `compression.type`
- `confluent.key.schema.validation`
- `confluent.value.schema.validation`

### Producer

- ⭐ `bootstrap.servers`
- ⭐ `key.serializer`
- ⭐ `value.serializer`
- ⭐ `acks`
- ⭐ `retries`
- ⭐ `batch.size`
- ⭐ `linger.ms`
- `client.id`
- `delivery.timeout.ms`
- `buffer.memory`
- `compression.type`
- `max.in.flight.requests.per.connection`
- `request.timeout.ms`
- `max.block.ms`
- `max.request.size`
- `receive.buffer.bytes`
- `send.buffer.bytes`

### Consumer

- ⭐ `bootstrap.servers`
- ⭐ `key.deserializer`
- ⭐ `value.deserializer`
- ⭐ `enable.auto.commit`
- ⭐ `auto.commit.interval.ms`
- ⭐ `auto.offset.reset`
- ⭐ `group.id`
- `client.id`
- `fetch.min.bytes`
- `fetch.max.wait.ms`
- `max.partition.fetch.bytes`
- `session.timeout.ms`
- `partition.assignment.strategy`
- `max.poll.records`
- `receive.buffer.bytes`
- `send.buffer.bytes`
