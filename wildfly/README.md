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
bash ./create-instance.sh --instance=inst1
bash ./create-instance.sh --instance=inst2

bash create-scripts.sh --instance=inst1 --port-offset=0
bash create-scripts.sh --instance=inst2 --port-offset=1
```

## Password encryption

### Credential Store

- https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/how_to_configure_server_security/index#credential_store

### Password Valut

```bash
bash ./encrypt-password-by-vault.sh ${PASSWORD}
```

- https://access.redhat.com/solutions/2790371
- https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/how_to_configure_server_security/index#password_vault

### PicketBox

```bash
bash ./encrypt-password-by-picketbox.sh ${PASSWORD}
```

- https://access.redhat.com/solutions/184963

## Datasource

### JDBC driver

```bash
### by module
bash ./add-jdbc-driver-by-module.sh --port-offset=0

### by deployment
bash ./add-jdbc-driver-by-deployment.sh --port-offset=0
```

### Datasource

```bash
bash ./add-datasource.sh --port-offset=0
bash ./set-datasource.sh --port-offset=0
bash ./delete-datasource.sh --port-offset=0 --name=baseds1
```

## Application

```bash
bash ./deploy-app.sh --port-offset=0 --path=/svc/app/test --name=test.war --runtime-name=test.war
bash ./undeploy-app.sh --port-offset=0 --name=test.war
bash ./redeploy-app.sh --port-offset=0 --path=/svc/app/test --name=test.war --runtime-name=test.war
```
