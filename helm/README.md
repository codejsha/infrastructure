# Helm

https://github.com/helm/charts/tree/master/stable/chartmuseum

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

Requirements: MinIO storage

[values.yaml](/helm/values.yaml):

```yaml
env:
  open:
    STORAGE: "amazon"
    STORAGE_AMAZON_BUCKET: "mychart"
    # STORAGE_AMAZON_PREFIX:
    # STORAGE_AMAZON_REGION:
    STORAGE_AMAZON_ENDPOINT: "http://minio.example.com"
  secret:
    AWS_ACCESS_KEY_ID: "<ACCESS_KEY>"
    AWS_SECRET_ACCESS_KEY: "<SECRET_KEY>"
```

Install:

```bash
bash ./helm-install-chartmuseum.sh
```
