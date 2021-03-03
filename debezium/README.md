# Debezium

## Architecture

- https://debezium.io/documentation/reference/1.4/architecture.html

![debezium-architecture](/contents/images/debezium-architecture.png)

## Tutorial

[Tutorial README](/debezium/tutorial/README.md)

## Sample database

- PostgreSQL: dvdrental (cf. [PostgreSQL README](/postgresql/README.md))
- MySQL: Sakila (cf. [MySQL README](/mysql/README.md))
- SQL Server: Northwind (cf. [SQL Server README](/sqlserver/README.md))

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
