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

## NiFi

- https://github.com/cetic/helm-nifi

```bash
bash ./helm-install-nifi.sh
```
