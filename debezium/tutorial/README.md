# Debezium Tutorial

- https://debezium.io/documentation/reference/1.3/tutorial.html
- https://github.com/debezium/debezium-examples/tree/master/tutorial

## Starting the services

```bash
# Start Zookeeper
bash ./docker-run-debezium-zookeeper.sh

# Start Kafka
bash ./docker-run-debezium-kafka.sh

# Start a MySQL database
bash ./docker-run-debezium-mysql.sh

# Start a MySQL command line client
bash ./docker-run-debezium-mysql-client.sh

# Start Kafka Connect
bash ./docker-run-debezium-kafka-connect.sh
```

## Deploying the MySQL connector

```bash
# Registering a connector to monitor
bash ./register-mysql-connector.sh
```

## Viewing change events

```bash
# Start the watch-topic utility to watch the topic
bash ./docker-run-debezium-kafka-watch-topic.sh
```

## Cleaning up

```bash
docker stop mysqlterm watcher connect mysql kafka zookeeper
```
