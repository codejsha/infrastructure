#!/usr/bin/bash

docker volume create postgresql11vol

docker run \
    --detach \
    --name postgresql11 \
    --publish 5432:5432 \
    --env POSTGRES_DB=postgres \
    --env POSTGRES_USER=postgres \
    --env POSTGRES_PASSWORD="${PASSWORD}" \
    --env PGDATA=/var/lib/postgresql/data/pgdata \
    --mount type=volume,src=postgresql11vol,dst=/var/lib/postgresql/data \
    postgres:11.6

######################################################################

docker volume create postgresql12vol

docker run \
    --detach \
    --name postgresql12 \
    --publish 5432:5432 \
    --env POSTGRES_DB=postgres \
    --env POSTGRES_USER=postgres \
    --env POSTGRES_PASSWORD="${PASSWORD}" \
    --env PGDATA=/var/lib/postgresql/data/pgdata \
    --mount type=volume,src=postgresql12vol,dst=/var/lib/postgresql/data \
    postgres:12.3
