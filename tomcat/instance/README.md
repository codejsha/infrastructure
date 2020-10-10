# Create instance

Requirements: tidy package

## General

```bash
### params: ${INSTANCE_NAME} ${HTTP_PORT} ${HTTPS_PORT} ${SHUTDOWN_PORT}
bash ./create-instance.sh inst1 8080 8443 8005
bash ./create-instance.sh inst2 8081 8444 8006
```

## Cluster

```bash
### params: ${INSTANCE_NAME} ${HTTP_PORT} ${HTTPS_PORT} ${SHUTDOWN_PORT} ${AJP_PORT}

bash ./create-instance-cluster.sh inst1 8080 8443 8005 8009
bash ./create-instance-cluster.sh inst2 8081 8444 8006 8010

bash ./create-instance-cluster-full.sh inst1 8080 8443 8005 8009
bash ./create-instance-cluster-full.sh inst2 8081 8444 8006 8010

bash ./create-instance-cluster-redis.sh inst1 8080 8443 8005 8009
bash ./create-instance-cluster-redis.sh inst2 8081 8444 8006 8010
```

> **NOTE**: The Tomcat clustering with Redis is requried the Redisson library.

https://github.com/redisson/redisson/tree/master/redisson-tomcat

## Create scripts

```bash
bash ./create-scripts.sh inst1
bash ./create-scripts.sh inst2
```
