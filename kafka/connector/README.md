# Kafka Connect Connectors

- https://debezium.io/
- https://www.confluent.io/hub/
- https://www.confluent.io/product/connectors/

## Debezium

- https://debezium.io/documentation/reference/1.4/index.html
- https://debezium.io/documentation/reference/1.4/architecture.html
- https://debezium.io/documentation/reference/1.4/tutorial.html

## Confluent

- https://docs.confluent.io/platform/current/connect/index.html
- https://docs.confluent.io/platform/current/connect/references/allconfigs.html
- https://docs.confluent.io/platform/current/connect/references/connector-configs.html

### REST API

- https://docs.confluent.io/platform/current/connect/references/restapi.html

connector plugin list:

```bash
curl --header "Accept:application/json" http://localhost:8083/connector-plugins | jq .[].class
curl --header "Accept:application/json" http://kafka-connect1:8083/connector-plugins | jq .[].class
curl --header "Accept:application/json" http://kafka-connect.example.com/connector-plugins | jq .[].class
```

connector list:

```bash
curl --header "Accept:application/json" http://localhost:8083/connectors | jq
curl --header "Accept:application/json" http://kafka-connect1:8083/connectors | jq
curl --header "Accept:application/json" http://kafka-connect.example.com/connectors | jq
```

## Connector examples

### AWS S3 Sink Connector

aws credentials in kafka-connect start script:

```bash
### aws credentials
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
```

s3 bucket configurations:

```json
    "store.url": "http://minio.example.com",
    "s3.region": "us-west-1",
    "s3.bucket.name": "kafka-s3-sink-storage",
    "s3.part.size": "5242880",
```

### Datagen Connector

- https://github.com/confluentinc/kafka-connect-datagen
- https://docs.confluent.io/platform/current/ksqldb/tutorials/basics-local.html

`DatagenTask.Quickstart` enum:

- `clickstream_codes`
- `clickstream`
- `clickstream_users`
- `orders`
- `ratings`
- `users`
- `users_`
- `pageviews`
- `stock_trades`
- `inventory`
- `product`

### FTP: SFTP CSV/JSON Source Connector

file path/pattern configurations:

```json
    "input.file.pattern": "",
    "input.path": "",
    "error.path": "",
    "finished.path": "",
```

### MySQL Source Connector

sample database: Sakila (cf. [MySQL README](/mysql/README.md))

include/exclude configurations:

```json
    "database.include.list": "",
    "database.exclude.list": "",
    "table.include.list": "",
    "table.exclude.list": "",
    "column.include.list": "",
    "column.exclude.list": "",
```

### PostgreSQL Source Connector

sample database: dvdrental (cf. [PostgreSQL README](/postgresql/README.md))

include/exclude configurations:

```json
    "database.dbname": "",
    "schema.include.list": "",
    "schema.exclude.list": "",
    "table.include.list": "",
    "table.exclude.list": "",
    "column.include.list": "",
    "column.exclude.list": "",
```

### SQL Server Source Connector

sample database: Northwind (cf. [SQL Server README](/sqlserver/README.md))

include/exclude configurations:

```json
    "database.dbname": "",
    "table.include.list": "",
    "table.exclude.list": "",
    "column.include.list": "",
    "column.exclude.list": "",
```
