# MinIO

- https://github.com/minio/minio
- https://github.com/minio/mc
- https://docs.minio.io/docs/aws-cli-with-minio.html
- https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-docker.html
- https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html

## Local

default root id/pw: `minioadmin:minioadmin`

```bash
bash ./install-minio.sh
```

start and stop scripts: `start-minio.sh`, `stop-minio.sh`

### Service

- https://github.com/minio/minio-service

## Docker

```bash
bash ./docker-run-minio.sh
```

## Kubernetes (Helm chart)

⚠️ Deprecated chart

- https://github.com/minio/charts

```bash
bash ./helm-install-minio.sh
```

## Kubernetes (Operator)

- https://github.com/minio/operator
- https://github.com/minio/console



kubectl apply --filename tenant-creds-secret.yaml
kubectl apply --filename tenant-console-secret.yaml
kubectl apply --namespace minio-tenant --filename tenant-certificate.yaml


### krew

```bash
### operator
bash ./operator-install-minio.sh
kubectl apply --namespace minio-operator --filename operator-console-ingress.yaml

### secret, certificate
kubectl apply --namespace minio-tenant --filename tenant-creds-secret.yaml
kubectl apply --namespace minio-tenant --filename tenant-console-secret.yaml
kubectl apply --namespace minio-tenant --filename tenant-certificate.yaml

### tenant
bash ./operator-create-tenant.sh

### ingress
kubectl apply --namespace minio-tenant --filename tenant-console-ingress.yaml
kubectl apply --namespace minio-tenant --filename tenant-ingress.yaml
```

### Kustomize

```bash
### operator
bash ./kustomize-install-minio-operator.sh
kubectl apply --namespace minio-operator --filename operator-console-ingress.yaml

### secret, certificate
kubectl apply --namespace minio-tenant --filename tenant-creds-secret.yaml
kubectl apply --namespace minio-tenant --filename tenant-console-secret.yaml
kubectl apply --namespace minio-tenant --filename tenant-certificate.yaml

### tenant
kubectl apply --namespace minio-tenant --filename tenant.yaml

### ingress
kubectl apply --namespace minio-tenant --filename tenant-console-ingress.yaml
kubectl apply --namespace minio-tenant --filename tenant-ingress.yaml
```

### Architecture

![minio-operator-architecture](/contents/images/minio-operator-architecture.png)

## Grafana dashboard

- https://grafana.com/grafana/dashboards/13502

## Command examples

- `aws-cli-minio-commands.sh`
- `minio-client-commands.sh`
