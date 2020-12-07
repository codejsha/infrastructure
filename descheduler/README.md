# Descheduler

- https://github.com/kubernetes-sigs/descheduler

## Install

### Repository

```bash
bash ./install-descheduler.sh
```

ConfigMap: `descheduler-policy-configmap.yaml`

### Helm

```bash
bash ./helm-install-descheduler.sh
```

ConfigMap: `${RELEASE_NAME}-descheduler-helm-chart.yaml`

cf. nameOverride, fullnameOverride

### Kustomize

```bash
bash ./kustomize-install-descheduler.sh
```

ConfigMap: `descheduler-policy-configmap.yaml`
