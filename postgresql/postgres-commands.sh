######################################################################

sudo su - postgres -c "psql"
# ALTER USER postgres PASSWORD ${POSTGRES_PASSWORD};

######################################################################

### connect

PGPASSWORD="${POSTGRES_PASSWORD}" psql -U postgres
PGPASSWORD="${POSTGRES_PASSWORD}" psql -h postgres.example.com -p 5432 -U postgres -d postgres
PGPASSWORD="${POSTGRES_PASSWORD}" psql --port=5432 --username=postgres --dbname=postgres
PGPASSWORD="${POSTGRES_PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --dbname=postgres

######################################################################

### database list

PGPASSWORD="${POSTGRES_PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="\l"
###                                        List of databases
###         Name         |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
### ---------------------+----------+----------+-------------+-------------+-----------------------
###  gitlabhq_production | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
###  postgres            | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
###  template0           | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
###                      |          |          |             |             | postgres=CTc/postgres
###  template1           | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
###                      |          |          |             |             | postgres=CTc/postgres
### (4 rows)

######################################################################

### create database

PGPASSWORD="${POSTGRES_PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="CREATE DTABASE ${DATABASE_NAME};"

######################################################################

### switch database

PGPASSWORD="${POSTGRES_PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="\c postgres"
### You are now connected to database "postgres" as user "postgres".

######################################################################

### table list

PGPASSWORD="${POSTGRES_PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --dbname=postgres \
    --command="\dt"

######################################################################

### role

PGPASSWORD="${POSTGRES_PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="\du"
###                                    List of roles
###  Role name |                         Attributes                         | Member of
### -----------+------------------------------------------------------------+-----------
###  postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}

######################################################################

### check connection

SHOW max_connections;
SELECT COUNT(*) FROM pg_stat_activity;
SELECT pid, query, state FROM pg_stat_activity;
SELECT pid, query, state FROM pg_stat_activity WHERE state LIKE 'idle';

######################################################################
