# Redis

## Kubernetes

### Install

```bash
bash ./helm-install-redis.sh
```

### External Access

To access enternally, deploy loadbalancers for master and slave pods.

```txt
LOADBALANCER           ENDPOINT                POD
redis-lb-master   -->  redis-lb-master   --->  my-redis-master-0
redis-lb-slave-0  -->  redis-lb-slave-0  --->  my-redis-slave-0
redis-lb-slave-1  -->  redis-lb-slave-1  --->  my-redis-slave-1
```

Run:

```bash
kubectl apply --filename redis-lb-master.yaml
kubectl apply --filename redis-lb-slave.yaml
```

## Docker Compose

- https://github.com/bitnami/bitnami-docker-redis
- https://github.com/bitnami/bitnami-docker-redis-cluster
