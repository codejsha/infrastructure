# Helm

- https://hub.docker.com/r/alpine/helm
- https://github.com/helm/charts/tree/master/stable/chartmuseum

## Install

```bash
bash ./install-helm.sh
```

### Using docker container

- [docker-run-helm-cli.sh](/helm/docker-run-helm-cli.sh)

### Push plugin

```bash
bash ./install-helm-push-plugin.sh
```

## ChartMuseum

### Install chart (Deprecated)

https://github.com/helm/charts#%EF%B8%8F-deprecation-and-archive-notice

configure blob storage:

```yaml
env:
  open:
    STORAGE: "amazon"
    STORAGE_AMAZON_BUCKET: "mychart-storage"
    # STORAGE_AMAZON_PREFIX:
    # STORAGE_AMAZON_REGION:
    STORAGE_AMAZON_ENDPOINT: "http://minio.example.com"
  secret:
    AWS_ACCESS_KEY_ID: "${AWS_ACCESS_KEY}"
    AWS_SECRET_ACCESS_KEY: "${AWS_SECRET_KEY}"
```

create bucket:

```bash
mc mb myminio/mychart-storage
```

install:

```bash
bash ./helm-install-chartmuseum.sh
```

### Health check

```bash
curl --insecure --verbose http://chartmuseum.example.com/health
```

### Add repo

```bash
helm repo add chartmuseum http://chartmuseum.example.com
```
