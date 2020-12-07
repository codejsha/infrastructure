# Kafka

## Install

```bash
### bitnami
bash ./helm-install-kafka.sh

### strimzi
bash ./helm-install-strimzi-kafka.sh
### strimzi operator
bash ./operator-install-strimzi-kafka.sh

### confluent
bash ./helm-install-confluent-kafka.sh
```

## CMAK (Cluster Manager for Apache Kafka) Operator

- https://github.com/eshepelyuk/cmak-operator

### Prerequisites

CMAK operator creates Kubernetes Jobs for configuring CMAK. Kubernetes Jobs are not automatically garbage collected. To enable cleanup it is required to enable `TTLAfterFinished` feature gate.

Enable feature gates:

```bash
### kubelet.service EnvironmentFile
sudo vi /etc/kubernetes/kubelet.env
```

```env
KUBELET_ARGS="--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf \
--config=/etc/kubernetes/kubelet-config.yaml \
--kubeconfig=/etc/kubernetes/kubelet.conf \
--pod-infra-container-image=k8s.gcr.io/pause:3.2 \
--runtime-cgroups=/systemd/system.slice \
--feature-gates=TTLAfterFinished=true \
   "
```

Restart kubelet:

```bash
sudo systemctl restart kubelet
```

### Install

```bash
bash ./helm-install-cmak.sh
kubectl apply --filename cmak-ingress.yaml
```

## NiFi

- https://github.com/cetic/helm-nifi

### Install

```bash
bash ./helm-install-nifi.sh
```
