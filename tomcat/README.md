# tomcat

## install

### general

```bash
### requirements
### tidy package
sudo yum install -y tidy

### usage
### ./create-instance.sh ${INSTANCE_NAME} ${HTTP_PORT} ${HTTPS_PORT} ${SHUTDOWN_PORT}
./create-instance.sh inst1 8080 8443 8005
./create-instance.sh inst2 8081 8444 8006
```

### cluster

```bash
### requirements
### tidy package
sudo yum install -y tidy

### usage
### ./create-instance-cluster-full.sh ${INSTANCE_NAME} ${HTTP_PORT} ${HTTPS_PORT} ${SHUTDOWN_PORT} ${AJP_PORT}
./create-instance-cluster-full.sh inst1 8080 8443 8005 8009
./create-instance-cluster-full.sh inst2 8081 8444 8006 8010
```

## web.xml

cf. [weblogic/web.xml](/weblogic/web.xml)
