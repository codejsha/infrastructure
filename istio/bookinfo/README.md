# Istio Bookinfo

- https://github.com/istio/istio/tree/master/samples/bookinfo
- https://istio.io/latest/docs/examples/bookinfo/

## Configuration

```bash
bash ./all.sh
```

for openshift:

```bash
bash ./deploy-bookinfo-openshift.sh
```

## Traffic managemet

### Virtual services

- bookinfo-vs-rewrite.yaml
- bookinfo-vs.yaml
- vs-all-v1.yaml
- vs-all.yaml
- vs-ratings-abort-fault.yaml
- vs-ratings-delay-fault.yaml
- vs-ratings-retry.yaml
- vs-reviews-80-20.yaml
- vs-reviews-match-v2.yaml
- vs-reviews-match-v3.yaml
- vs-reviews-retry.yaml
- vs-reviews-v1.yaml

### Destination rules

- dr-all.yaml
- dr-reviews-conn-pool.yaml
- dr-reviews-least-conn.yaml
- dr-reviews-outlier.yaml
- dr-reviews-random.yaml
- dr-reviews-round-robin.yaml
- dr-reviews-timeout.yaml

### Gateways

- bookinfo-gw.yaml
