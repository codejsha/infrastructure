# Rook-Ceph

- https://rook.github.io/docs/rook/v1.6/ceph-quickstart.html
- https://rook.github.io/docs/rook/v1.6/ceph-block.html
- https://rook.github.io/docs/rook/v1.6/ceph-csi-drivers.html
- https://rook.github.io/docs/rook/v1.6/ceph-dashboard.html
- https://rook.io/docs/rook/v1.6/ceph-upgrade.html

## Install

### Kubernetes

```bash
bash ./operator-install-rook-ceph.sh
bash ./operator-install-rook-ceph-cluster.sh
```

### minikube

```bash
bash ./operator-install-rook-ceph.sh
bash ./operator-install-rook-ceph-cluster-minikube.sh
```

### OpenShift

```bash
bash ./operator-install-rook-ceph-openshift.sh
bash ./operator-install-rook-ceph-cluster-openshift.sh
```

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
