# Istio

- https://istio.io/latest/docs/setup/install/istioctl/
- https://istio.io/latest/docs/setup/install/operator/
- https://istio.io/latest/docs/setup/additional-setup/config-profiles/
- https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/
- https://istio.io/latest/docs/tasks/observability/gateways/
- https://istio.io/latest/docs/setup/install/operator/
- https://istio.io/latest/docs/tasks/observability/logs/access-log/

## Install

### Operator

```bash
bash ./operator-install-istio.sh
```

### Addons

```bash
bash ./install-addon.sh
bash ./remote-access-setup-cert.sh
bash ./remote-access-grafana.sh
bash ./remote-access-kiali.sh
bash ./remote-access-prometheus.sh
bash ./remote-access-tracing.sh
```
