$password="$password"

######################################################################

function New-DockerRunPostgreSQL11 {
    docker volume create postgresql11vol

    docker run `
        --detach `
        --name postgresql11 `
        --publish 5432:5432 `
        --env POSTGRES_DB=postgres `
        --env POSTGRES_USER=postgres `
        --env POSTGRES_PASSWORD="$password" `
        --env PGDATA=/var/lib/postgresql/data/pgdata `
        --mount type=volume,src=postgresql11vol,dst=/var/lib/postgresql/data `
        postgres:11
}

function New-DockerRunPostgreSQL12 {
    docker volume create postgresql12vol

    docker run `
        --detach `
        --name postgresql12 `
        --publish 5432:5432 `
        --env POSTGRES_DB=postgres `
        --env POSTGRES_USER=postgres `
        --env POSTGRES_PASSWORD="$password" `
        --env PGDATA=/var/lib/postgresql/data/pgdata `
        --mount type=volume,src=postgresql12vol,dst=/var/lib/postgresql/data `
        postgres:12
}

function New-DockerRunPostgreSQL13 {
    docker volume create postgresql13vol

    docker run `
        --detach `
        --name postgresql13 `
        --publish 5432:5432 `
        --env POSTGRES_DB=postgres `
        --env POSTGRES_USER=postgres `
        --env POSTGRES_PASSWORD="$password" `
        --env PGDATA=/var/lib/postgresql/data/pgdata `
        --mount type=volume,src=postgresql13vol,dst=/var/lib/postgresql/data `
        postgres:13
}

######################################################################

# New-DockerRunPostgreSQL11
# New-DockerRunPostgreSQL12
New-DockerRunPostgreSQL13
