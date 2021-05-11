# Kafka

## Docker Compose

```bash
docker create network stream-network

docker-compose up -d
# docker-compose up -d -f docker-compose.yaml
```

## Kubernetes (Helm chart)

```bash
bash ./helm-install-kafka.sh
```

## Confluent

[Confluent README](/kafka/confluent/README.md)

## Strimzi Kafka

- https://strimzi.io/documentation/
- https://github.com/strimzi/strimzi-kafka-operator

```bash
### helm chart
bash ./helm-install-strimzi-kafka.sh

### operator
bash ./operator-install-strimzi-kafka.sh
```

## CMAK (Cluster Manager for Apache Kafka)

- https://github.com/yahoo/CMAK

```bash
bash ./kube-run-cmak.sh
```

## kafkacat

- https://github.com/edenhill/kafkacat

## Burrow

- https://github.com/linkedin/Burrow

## Xinfra Monitor

- https://github.com/linkedin/kafka-monitor

## Cruise Control

- https://github.com/linkedin/cruise-control

## Kafdrop

- https://github.com/obsidiandynamics/kafdrop

## Secor

- https://github.com/pinterest/secor

## Apache NiFi

- https://nifi.apache.org/docs.html
- https://github.com/apache/nifi
- https://github.com/cetic/helm-nifi

```bash
bash ./helm-install-nifi.sh
```

## Configuration parameters

### Topic

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
