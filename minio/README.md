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

### Architecture

![minio-operator-architecture](/contents/images/minio-operator-architecture.png)

## Grafana dashboard

- https://grafana.com/grafana/dashboards/13502

## Command examples

- `aws-cli-minio-commands.sh`
- `minio-client-commands.sh`
