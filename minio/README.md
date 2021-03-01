# MinIO

- https://github.com/minio/minio
- https://github.com/minio/mc
- https://docs.minio.io/docs/aws-cli-with-minio.html
- https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-docker.html

## Local

```bash
bash ./install-minio.sh
```

## Docker

```bash
bash ./docker-run-minio.sh
```

## Kubernetes

### Helm chart

```bash
bash ./helm-install-minio.sh
```

### Operator

- https://github.com/minio/operator
- https://github.com/minio/console

#### krew

```bash
### install and configure
bash ./operator-install-minio.sh
bash ./operator-create-minio-tenant.sh

### ingress
kubectl apply -f ./tenant-console-ingress.yaml

### delete
bash ./operator-delete-minio-tenant.sh
```

#### kustomize

```bash
### install and configure
bash ./kustomize-install-minio-operator.sh
kubectl apply -n minio-tenant -f ./tenant.yaml

### ingress
kubectl apply -f ./tenant-console-ingress.yaml

### delete
kubectl delete -n minio-tenant -f ./tenant.yaml
```

#### Architecture

![minio-operator-architecture](/contents/images/minio-operator-architecture.png)

### Grafana dashboard

https://grafana.com/grafana/dashboards/13502

## Command examples

- `aws-cli-minio-commands.sh`
- `minio-client-commands.sh`
