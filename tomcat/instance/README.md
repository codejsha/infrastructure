# Create instances

Optional: tidy package (if you use it)

## Instance

```bash
### params: ${INSTANCE_NAME} ${HTTP_PORT} ${HTTPS_PORT} ${SHUTDOWN_PORT}

bash ./create-instance.sh inst1 8080 8443 8005
bash ./create-instance.sh inst2 8081 8444 8006
```

## Cluster

### General (Multicast)

```bash
### params: ${INSTANCE_NAME} ${HTTP_PORT} ${HTTPS_PORT} ${SHUTDOWN_PORT} ${AJP_PORT} ${JMX_PORT}

bash ./create-instance-cluster.sh inst1 8080 8443 8005 8009 8050
bash ./create-instance-cluster.sh inst2 8081 8444 8006 8010 8051

bash ./create-instance-cluster-full.sh inst1 8080 8443 8005 8009 8050
bash ./create-instance-cluster-full.sh inst2 8081 8444 8006 8010 8051
```

### With Redis

Set redisson mode in `env-redisson.sh`:

```bash
# REDISSON_MODE="CLUSTER_MODE"
REDISSON_MODE="MASTER_SLAVE_MODE"
# REDISSON_MODE="SINGLE_MODE"
```

Create instances:

```bash
### params: ${INSTANCE_NAME} ${HTTP_PORT} ${HTTPS_PORT} ${SHUTDOWN_PORT} ${AJP_PORT} ${JMX_PORT}

bash ./create-instance-cluster-redis.sh inst1 8080 8443 8005 8009 8050
bash ./create-instance-cluster-redis.sh inst2 8081 8444 8006 8010 8051
```

Set addresses and password(If Redis has a password) in redisson.yaml.

Add libraries:

Add redisson-all-xxx.jar, redisson-tomcat-xxx.jar into `${CATALINA_BASE}/lib` directory.

https://github.com/redisson/redisson/tree/master/redisson-tomcat

## Create scripts

```bash
bash ./create-scripts.sh inst1
bash ./create-scripts.sh inst2
```
