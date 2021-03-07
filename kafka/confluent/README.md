# Confluent Kafka

## Local

```bash
bash ./install-confluent-kafka.sh
```

## Kubernetes (Open source Helm charts)

```bash
bash ./helm-install-open-source-confluent-kafka.sh
```

## Kubernetes Operator (with Helm)

### Install

using util:

```bash
bash ./operator-install-confluent-kafka.sh
kubectl apply --filename control-center-ingress.yaml

### install / upgrade / upgrade --install
bash ./helm-install-confluent-util-kafka.sh
bash ./helm-install-confluent-util-operator.sh
bash ./helm-install-confluent-util-others.sh
bash ./helm-install-confluent-util-zookeeper.sh
```

using cli:

```bash
bash ./helm-install-confluent-operator.sh
bash ./helm-install-confluent-zookeeper.sh
bash ./helm-install-confluent-kafka.sh
bash ./helm-install-confluent-schema-registry.sh
bash ./helm-install-confluent-kafka-connect.sh
bash ./helm-install-confluent-replicator.sh
bash ./helm-install-confluent-ksql.sh
bash ./helm-install-confluent-control-center.sh
kubectl apply --filename control-center-ingress.yaml
```

### Namespaced deployment (namespace-level)

```bash
bash ./apply-namespaced-deployment.sh
```

### Add license

edit `confluent-license.yaml`, and apply:

```bash
bash ./add-license.sh
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

cf. partition, replication factor

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
