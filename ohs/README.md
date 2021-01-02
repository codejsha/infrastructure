# OHS (Oracle HTTP Server)

## Install

```bash
bash ./install-ohs.sh
```

## Configuration

```bash
bash ./all.sh
```

### 11g

```bash
bash ./create-instance-11g.sh
bash ./create-component-11g.sh

bash ./create-scripts-11g.sh

bash ./create-httpd-scripts-11g.sh
bash ./create-links-script-11g.sh
```

### 12cR1

```bash
bash ./create-domain.sh
bash ./create-component.sh

bash ./create-nodemgr-scripts.sh
bash ./create-scripts.sh

bash ./create-httpd-scripts-12cr1.sh
bash ./create-links-script.sh
bash ./create-metric-scripts.sh
```

### 12cR2

```bash
bash ./create-domain.sh
bash ./create-component.sh

bash ./create-nodemgr-scripts.sh
bash ./create-scripts.sh

bash ./create-httpd-scripts.sh
bash ./create-links-script.sh
bash ./create-metric-scripts.sh
```

## Metrics (12c)

```bash
bash ${DOMAIN_HOME}/scripts/get-dump-metrics-${COMPONENT_NAME}.sh

bash ${DOMAIN_HOME}/scripts/get-metrics-plugin-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-process-info-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-module-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-moduleset-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-response-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-server-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-vhostset-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-vhost-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-vhostaddr-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-vhostaddrs-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-system-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-system-host-${COMPONENT_NAME}.sh
bash ${DOMAIN_HOME}/scripts/get-metrics-system-process-${COMPONENT_NAME}.sh
```
