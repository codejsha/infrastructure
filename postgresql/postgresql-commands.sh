######################################################################

# get the default config
docker container run --rm -i postgres cat /usr/share/postgresql/postgresql.conf.sample > postgres-default.conf

######################################################################

sudo su - postgres -c "psql"
# ALTER USER postgres PASSWORD ${PASSWORD};

######################################################################

### connect

PGPASSWORD="${PASSWORD}" psql -U postgres
PGPASSWORD="${PASSWORD}" psql -h test.example.com -p 5432 -U postgres -d postgres
PGPASSWORD="${PASSWORD}" psql -h postgres.example.com -p 5432 -U postgres -d postgres
PGPASSWORD="${PASSWORD}" psql --port=5432 --username=postgres --dbname=postgres
PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --dbname=postgres

######################################################################

### database list

PGPASSWORD="${PASSWORD}" \
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

PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="CREATE DTABASE ${DATABASE_NAME};"

######################################################################

### switch database

PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="\c postgres"
### You are now connected to database "postgres" as user "postgres".

######################################################################

### table list

PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --dbname=postgres \
    --command="\dt"

######################################################################

### role

PGPASSWORD="${PASSWORD}" \
    psql \
    --host=postgres-lb.example.com \
    --port=5432 \
    --username=postgres \
    --command="\du"
###                                    List of roles
###  Role name |                         Attributes                         | Member of
### -----------+------------------------------------------------------------+-----------
###  postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
