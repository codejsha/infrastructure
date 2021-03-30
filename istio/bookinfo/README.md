# Istio Bookinfo

- https://github.com/istio/istio/tree/master/samples/bookinfo
- https://istio.io/latest/docs/examples/bookinfo/

## Deploy

```bash
bash ./all.sh

### kustomize
bash ./kustomize-install-bookinfo.sh
```

## Traffic management

### Virtual services

- `bookinfo-vs-rewrite.yaml`
- `bookinfo-vs.yaml`
- `vs-all-v1.yaml`
- `vs-all.yaml`
- `vs-ratings-abort-fault.yaml`
- `vs-ratings-delay-fault.yaml`
- `vs-ratings-retry.yaml`
- `vs-reviews-80-20.yaml`
- `vs-reviews-match-v2.yaml`
- `vs-reviews-match-v3.yaml`
- `vs-reviews-retry.yaml`
- `vs-reviews-v1.yaml`

### Destination rules

- `dr-all.yaml`
- `dr-reviews-conn-pool.yaml`
- `dr-reviews-least-conn.yaml`
- `dr-reviews-outlier.yaml`
- `dr-reviews-random.yaml`
- `dr-reviews-round-robin.yaml`
- `dr-reviews-timeout.yaml`

### Gateways

- `bookinfo-gw.yaml`
