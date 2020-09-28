# Rook-Ceph

## Cluster

`rook/cluster/examples/kubernetes/ceph/cluster.yaml`

### Prefix for loadbalancer or ingress

```yaml
spec:
  dashboard:
    urlPrefix: /ceph-dashboard
```

### Specific devices

```yaml
spec:
  nodes:
  - name: "10.10.10.21"
    devices:
    - name: "sdb"
  - name: "10.10.10.22"
    devices:
    - name: "sdb"
  - name: "10.10.10.23"
    devices:
    - name: "sdb"
```

cf. `lsblk` command

## Dashboard

### Ingress

`rook/cluster/examples/kubernetes/ceph/dashboard-ingress-https.yaml`

```yaml
spec:
  tls:
   - hosts:
     - rook-ceph.example.com
     secretName: rook-ceph.example.com
  rules:
  - host: rook-ceph.example.com
```

### Loadbalancer

`rook/cluster/examples/kubernetes/ceph/dashboard-loadbalancer.yaml`

```yaml
spec:
  loadBalancerIP: 10.10.10.50
```

## Default storageclass

`change-default-storageclass.sh`

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
//...
```
