-- create user
CREATE USER debezium WITH ENCRYPTED PASSWORD 'dbz';
ALTER ROLE debezium WITH REPLICATION LOGIN;

-- grant table permission
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO debezium;
