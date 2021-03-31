$password="$password"

$PostgreSQLVolumeDir = "$env:USERPROFILE\volume\postgresql"
New-Item -Path $PostgreSQLVolumeDir -ItemType Directory -Force

######################################################################

function New-DockerRunPostgreSQL13 {
    docker container run `
        --detach `
        --name postgresql13 `
        --publish 5432:5432 `
        --env POSTGRES_DB="postgres" `
        --env POSTGRES_USER="postgres" `
        --env POSTGRES_PASSWORD="$password" `
        --env PGDATA="/var/lib/postgresql/data/pgdata" `
        --mount type="bind",src="$PostgreSQLVolumeDir/data",dst="/var/lib/postgresql/data" `
        postgres:13
}

function New-DockerRunPostgreSQL12 {
    docker container run `
    --detach `
    --name postgresql12 `
    --publish 5432:5432 `
    --env POSTGRES_DB="postgres" `
    --env POSTGRES_USER="postgres" `
    --env POSTGRES_PASSWORD="$password" `
    --env PGDATA="/var/lib/postgresql/data/pgdata" `
        --mount type="bind",src="$PostgreSQLVolumeDir/data",dst="/var/lib/postgresql/data" `
        postgres:12
}

function New-DockerRunPostgreSQL11 {
    docker container run `
        --detach `
        --name postgresql11 `
        --publish 5432:5432 `
        --env POSTGRES_DB="postgres" `
        --env POSTGRES_USER="postgres" `
        --env POSTGRES_PASSWORD="$password" `
        --env PGDATA="/var/lib/postgresql/data/pgdata" `
        --mount type="bind",src="$PostgreSQLVolumeDir/data",dst="/var/lib/postgresql/data" `
        postgres:11
}

######################################################################

New-DockerRunPostgreSQL13
# New-DockerRunPostgreSQL12
# New-DockerRunPostgreSQL11
