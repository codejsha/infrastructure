# WebLogic Configuration

## Configuration

```bash
bash ./all.sh
```

## Domain

- [conf-domain.sh](/weblogic/config/conf-domain.sh)
- [set-domain-config-archive.sh](/weblogic/config/set-domain-config-archive.sh) - [set_domain_config_archive.py](/weblogic/config/set_domain_config_archive.py)
- [set-domain-connection-filter.sh](/weblogic/config/set-connection-filter.sh) - [set_connection_filter.py](/weblogic/config/set_connection_filter.py)
- [set-domain-cookie-name.sh](/weblogic/config/set-domain-cookie-name.sh) - [set_domain_cookie_name.py](/weblogic/config/set_domain_cookie_name.py)
- [set-domain-jta.sh](/weblogic/config/set-domain-jta.sh) - [set_domain_jta.py](/weblogic/config/set_domain_jta.py)
- [set-domain-log.sh](/weblogic/config/set-domain-log.sh) - [set_domain_log.py](/weblogic/config/set_domain_log.py)

## Identity

- [create-boot-properties.sh](/weblogic/config/create-boot-properties.sh)
- [create-change-password-script.sh](/weblogic/config/create-change-password-script.sh)
- [create-store-user-config-scripts.sh](/weblogic/config/create-store-user-config-scripts.sh)
- [create-change-store-user-config-script.sh](/weblogic/config/create-change-store-user-config-script.sh)
- [create-encrypt-password-script.sh](/weblogic/config/create-encrypt-password-script.sh)

## Server

- [create-server.sh](/weblogic/config/create-server.sh) - [create_server.py](/weblogic/config/create_server.py)
- [create-scripts.sh](/weblogic/config/create-scripts.sh)

## Cluster

- [create-cluster.sh](/weblogic/config/create-cluster.sh) - [create_cluster.py](/weblogic/config/create_cluster.py)

## Data source

- [create-datasource.sh](/weblogic/config/create-datasource.sh) - [create_datasource.py](/weblogic/config/create_datasource.py)

### Diagnostics Profile Type

(Data Source) > Configuration > Diagnostics

set profile type to sum of bit

| Name                                      |  Bit |
| ----------------------------------------- | ---: |
| Profile Connection Usage                  |    1 |
| Profile Connection Reservation Wait       |    2 |
| Profile Connection Leak                   |    4 |
| Profile Connection Reservation Failed     |    8 |
| Profile Statement Cache Entry             |   16 |
| Profile Statement Usage                   |   32 |
| Profile Connection Last Usage             |   64 |
| Profile Connection Multithreaded Usage    |  128 |
| Profile Connection Unwrap                 |  256 |
| Profile Connection Local Transaction Leak |  512 |
| Profile Closed Usage                      | 1024 |

## Node manager

- [create-nodemgr.sh](/weblogic/config/create-nodemgr.sh) - [create_nodemgr.py](/weblogic/config/create_nodemgr.py)
- [create-nodemgr-scripts.sh](/weblogic/config/create-nodemgr-scripts.sh)
- [create-regen-demo-identity-script.sh](/weblogic/config/create-regen-demo-identity-script.sh)

## Application

- [deploy-app.sh](/weblogic/config/deploy-app.sh) - [deploy_app.py](/weblogic/config/deploy_app.py)
