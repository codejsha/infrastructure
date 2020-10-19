# Wildfly / JBoss

## Install

```bash
bash ./install-wildfly.sh
```

## Configuration

```bash
bash ./all.sh
```

## Create instances

```bash
### ./create-instance.sh ${INSTANCE_NAME} ${PORT_OFFSET}
bash ./create-instance.sh inst1 0
bash ./create-instance.sh inst2 1
```

## Password encryption

### valut

```bash
bash ./encrypt-password-by-vault.sh ${PASSWORD}
```

- https://access.redhat.com/solutions/2790371
- https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/how_to_configure_server_security/index#password_vault

### picketbox

```bash
bash ./encrypt-password-by-picketbox.sh ${PASSWORD}
```

- https://access.redhat.com/solutions/184963

## Datasource

### JDBC driver

```bash
### by module
bash ./add-jdbc-driver-by-module.sh

### by deployment
bash ./add-jdbc-driver-by-deployment.sh
```

### Datasource

```bash
bash ./add-datasource.sh
bash ./set-datasource.sh
bash ./delete-datasource.sh ${DATASOURCE_NAME}
```

## Application

```bash
bash ./deploy-app.sh ${APP_PATH} ${APP_NAME} ${APP_RUNTIME_NAME}
bash ./undeploy-app.sh ${APP_NAME}
bash ./redeploy-app.sh ${APP_PATH} ${APP_NAME} ${APP_RUNTIME_NAME}
```
