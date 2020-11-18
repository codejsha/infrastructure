# OHS (Oracle HTTP Server)

## Install

```bash
bash install-ohs.sh
```

## Configuration

### 11g

```bash
bash create-instance-11g.sh
bash create-component-11g.sh

bash create-scripts-11g.sh

bash get-version-11g.sh
```

### 12cr1

```bash
bash create-domain.sh
bash create-component.sh

bash create-nodemgr-scripts.sh
bash create-scripts.sh
bash create-httpd-scripts.sh
bash create-metric-scripts.sh

bash get-version-12c.sh
```

### 12cr2

```bash
bash create-domain.sh
bash create-component.sh

bash create-nodemgr-scripts.sh
bash create-scripts.sh
bash create-httpd-scripts.sh
bash create-metric-scripts.sh

bash get-version-12c.sh
```

## Metrics (12c)

```bash
bash get-metrics-${COMPONENT_NAME}.sh OHSWebLogic
bash get-metrics-${COMPONENT_NAME}.sh dms_cProcessInfo
bash get-metrics-${COMPONENT_NAME}.sh ohs_module
bash get-metrics-${COMPONENT_NAME}.sh ohs_moduleSet
bash get-metrics-${COMPONENT_NAME}.sh ohs_responses
bash get-metrics-${COMPONENT_NAME}.sh ohs_server
bash get-metrics-${COMPONENT_NAME}.sh ohs_vhostSet
bash get-metrics-${COMPONENT_NAME}.sh ohs_virtualHost
bash get-metrics-${COMPONENT_NAME}.sh ohs_virtualHostAddr
bash get-metrics-${COMPONENT_NAME}.sh ohs_virtualHostAddrs
bash get-metrics-${COMPONENT_NAME}.sh system
bash get-metrics-${COMPONENT_NAME}.sh system_host
bash get-metrics-${COMPONENT_NAME}.sh system_process

bash get-dump-metrics-${COMPONENT_NAME}.sh
```
