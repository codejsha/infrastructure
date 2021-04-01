# Elastic Stack

- https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html
- https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html
- https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-volume-claim-templates.html

## Kubernetes (Operator)

```bash
bash ./operator-install-elastic-operator.sh
bash ./operator-install-elasticsearch.sh
bash ./operator-install-kibana.sh
kubectl apply --namespace elastic-system --filename kibana-ingress.yaml
```

## Fluentd

### Grafana dashboard

- https://grafana.com/grafana/dashboards/13042
