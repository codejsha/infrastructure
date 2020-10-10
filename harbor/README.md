# Harbor

## Install

```bash
bash ./helm-install-harbor.sh
```

## Pods

```txt
NAME                                              READY   STATUS    RESTARTS   AGE
my-harbor-harbor-chartmuseum-899494b6b-bzrpc      1/1     Running   0          96s
my-harbor-harbor-clair-6dd897f647-m942n           2/2     Running   3          95s
my-harbor-harbor-core-bfbd5d47-hxqjv              1/1     Running   0          96s
my-harbor-harbor-database-0                       1/1     Running   0          95s
my-harbor-harbor-jobservice-584d69f748-j6skd      1/1     Running   0          96s
my-harbor-harbor-notary-server-8647ccbfb-72ktp    1/1     Running   1          96s
my-harbor-harbor-notary-signer-689d774cfd-468hw   1/1     Running   1          96s
my-harbor-harbor-portal-948bf95b6-rll4g           1/1     Running   0          96s
my-harbor-harbor-redis-0                          1/1     Running   0          96s
my-harbor-harbor-registry-6499f7457-t5g24         2/2     Running   0          95s
my-harbor-harbor-trivy-0                          1/1     Running   0          95s
```
