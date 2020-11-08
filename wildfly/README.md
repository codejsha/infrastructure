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
bash ./encrypt-password-with-vault.sh ${PASSWORD}
```

- https://access.redhat.com/solutions/2790371
- https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.3/html-single/how_to_configure_server_security/index#password_vault

### PicketBox

```bash
bash ./encrypt-password-with-picketbox.sh ${PASSWORD}
```

- https://access.redhat.com/solutions/184963

## Datasource

### JDBC driver

```bash
### by module
bash ./add-jdbc-driver-with-module.sh
bash ./delete-module.sh

### by deployment
bash ./add-jdbc-driver-with-deployment.sh

bash ./delete-jdbc-driver.sh
```

### Datasource

```bash
bash ./add-datasource.sh
bash ./set-datasource.sh
bash ./check-datasource.sh
bash ./delete-datasource.sh --name=baseds1
```

## Deployemnt

```bash
bash ./deploy-app.sh --path=/svc/app/test --name=test.war --runtime-name=test.war
bash ./undeploy-app.sh --name=test.war
bash ./redeploy-app.sh --path=/svc/app/test --name=test.war --runtime-name=test.war
```

## Filter

```bash
bash ./add-filter.sh
bash ./add-samesite-filter.sh
bash ./add-stuck-thread-detector.sh
bash ./hide-server-info.sh
```
