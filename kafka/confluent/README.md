# Confluent

- https://docs.confluent.io/platform/current/overview.html
- https://github.com/confluentinc/jmx-monitoring-stacks

## Local

```bash
bash ./install-confluent-kafka.sh
```

## Docker Compose

```bash
docker create network stream-network

docker-compose up -d
# docker-compose up -d -f docker-compose.yaml
```

## Kubernetes (Operator with Helm)

### Install

using cli:

```bash
bash ./helm-install-confluent-operator.sh
bash ./helm-install-confluent-zookeeper.sh
bash ./helm-install-confluent-kafka.sh
bash ./helm-install-confluent-schema-registry.sh
bash ./helm-install-confluent-kafka-connect.sh
bash ./helm-install-confluent-replicator.sh
bash ./helm-install-confluent-ksqldb.sh
bash ./helm-install-confluent-control-center.sh
kubectl apply --filename control-center-ingress.yaml
kubectl apply --filename kafka-connect0-ingress.yaml
```

using util:

```bash
bash ./operator-install-confluent-kafka.sh

### install / upgrade / upgrade --install
bash ./helm-install-confluent-util-operator.sh
bash ./helm-install-confluent-util-zookeeper.sh
bash ./helm-install-confluent-util-kafka.sh
bash ./helm-install-confluent-util-others.sh

kubectl apply --filename control-center-ingress.yaml
kubectl apply --filename kafka-connect0-ingress.yaml
```

### Namespaced deployment (namespace-level)

```bash
bash ./apply-namespaced-deployment.sh
```

## Kubernetes (Open source Helm charts)

```bash
bash ./helm-install-open-source-confluent-kafka.sh
```
