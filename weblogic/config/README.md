# WebLogic Configuration

## Configuration

```bash
bash ./all.sh
```

## Domain

| Script                               | WLST Script                          |
| ------------------------------------ | ------------------------------------ |
| `conf-domain.sh`                     |                                      |
| `set-domain-config-archive.sh`       | `set_domain_config_archive.py`       |
| `set-domain-connection-filter.sh`    | `set_domain_connection_filter.py`    |
| `set-domain-cookie-name.sh`          | `set_domain_cookie_name.py`          |
| `set-domain-jta.sh`                  | `set_domain_jta.py`                  |
| `set-domain-log.sh`                  | `set_domain_log.py`                  |
| `set-domain-output-compression.sh`   | `set_domain_output_compression.py`   |
| `set-domain-restful-mgmt-service.sh` | `set_domain_restful_mgmt_service.py` |
| `set-domain-web-app.sh`              | `set_domain_web_app.py`              |

## Identity

| Script                                        |
| --------------------------------------------- |
| `create-boot-properties.sh`                   |
| `create-change-password-script.sh`            |
| `create-change-store-user-config-script.sh`   |
| `create-store-user-config-admin-scripts.sh`   |
| `create-store-user-config-managed-scripts.sh` |
| `create-encrypt-password-script.sh`           |

## Server

| Script                      | WLST Script            |
| --------------------------- | ---------------------- |
| `create-server.sh`          | `create_server.py`     |
| `set-server-config.sh`      | `set_server_config.py` |
| `create-admin-scripts.sh`   |                        |
| `create-managed-scripts.sh` |                        |

## Cluster

| Script                  | WLST Script             |
| ----------------------- | ----------------------- |
| `create-cluster.sh`     | `create_cluster.py`     |
| `set-cluster-config.sh` | `set_cluster_config.py` |

## Data source

| Script                     | WLST Script                |
| -------------------------- | -------------------------- |
| `create-datasource.sh`     | `create_datasource.py`     |
| `set-datasource-config.sh` | `set_datasource_config.py` |

## Node manager

| Script                                 | WLST Script             |
| -------------------------------------- | ----------------------- |
| `create-nodemgr.sh`                    | `create_nodemgr.py`     |
| `set-nodemgr-config.sh`                | `set_nodemgr_config.py` |
| `create-nodemgr-scripts.sh`            |                         |
| `create-regen-demo-identity-script.sh` |                         |

## Application

| Script          | WLST Script     |
| --------------- | --------------- |
| `deploy-app.sh` | `deploy_app.py` |
