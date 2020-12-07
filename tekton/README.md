# Tekton

- https://github.com/tektoncd/pipeline
- https://github.com/tektoncd/dashboard
- https://github.com/tektoncd/triggers
- https://github.com/tektoncd/operator

## Install

```bash
bash ./install-tekton-cli.sh
bash ./install-tekton-dashboard.sh
bash ./install-tekton-pipeline.sh
bash ./install-tekton-trigger.sh
kubectl apply --filename tekton-dashboard-ingress.yaml
```

for operator:

```bash
bash ./operator-install-dashboard.sh
bash ./operator-install-tekton.sh
bash ./operator-install-trigger.sh
kubectl apply --filename tekton-dashboard-ingress.yaml
```
