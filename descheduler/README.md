# Descheduler

- https://github.com/kubernetes-sigs/descheduler

## Kubernetes (from repository)

```bash
bash ./install-descheduler.sh
```

ConfigMap: `descheduler-policy-configmap.yaml`

## Kubernetes (Helm chart)

```bash
bash ./helm-install-descheduler.sh
```

ConfigMap: `${RELEASE_NAME}-descheduler-helm-chart.yaml`

cf. nameOverride, fullnameOverride

## Kubernetes (Operator)

```bash
bash ./kustomize-install-descheduler.sh
```

ConfigMap: `descheduler-policy-configmap.yaml`
