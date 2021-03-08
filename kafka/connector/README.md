# Connector

- https://www.confluent.io/hub/

## REST API

connector plugin list:

```bash
curl --header "Accept:application/json" http://kafka-connect.example.com/connector-plugins | jq .[].class
```

connector list:

```bash
curl --header "Accept:application/json" http://kafka-connect.example.com/connectors | jq
```

## Debezium

- https://debezium.io/documentation/reference/1.4/architecture.html
- https://debezium.io/documentation/reference/1.4/tutorial.html

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

### AWS S3 Sink Connector

aws credentials in kafka-connect start script:

```bash
### aws credentials
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
```

s3 bucket configurations:

```json
    "store.url": "http://test.example.com:9000",
    "s3.region": "us-west-1",
    "s3.bucket.name": "kafka-s3-sink-storage",
    "s3.part.size": "5242880",
```

### Datagen Connector

- https://github.com/confluentinc/kafka-connect-datagen