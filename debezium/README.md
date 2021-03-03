# Debezium

## Architecture

- https://debezium.io/documentation/reference/1.4/architecture.html

![debezium-architecture](/contents/images/debezium-architecture.png)

## Tutorial

[Tutorial README](/debezium/tutorial/README.md)

## Example database

- PostgreSQL: dvdrental cf. [PostgreSQL README](/postgresql/README.md)
- MySQL: Sakila (https://dev.mysql.com/doc/index-other.html)
- SQL Server: Northwind (https://github.com/microsoft/sql-server-samples)

## Configuration

### include/exclude

PostgreSQL:

```json
    "database.dbname": "",
    "schema.include.list": "",
    "schema.exclude.list": "",
    "table.include.list": "",
    "table.exclude.list": "",
    "column.include.list": "",
    "column.exclude.list": "",
```

MySQL:

```json
    "database.include.list": "",
    "database.exclude.list": "",
    "table.include.list": "",
    "table.exclude.list": "",
    "column.include.list": "",
    "column.exclude.list": "",
```

SQL Server:

```json
    "database.dbname": "",
    "table.include.list": "",
    "table.exclude.list": "",
    "column.include.list": "",
    "column.exclude.list": "",
```
