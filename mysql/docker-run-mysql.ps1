$password = "$password"

######################################################################

function New-DockerRunMySQL8 {
    docker run `
        --detach `
        --name mysql8 `
        --publish 3306:3306 `
        --env MYSQL_ROOT_PASSWORD="$password" `
        --env PGDATA=/var/lib/postgresql/data/pgdata `
        --mount type=bind,src=$env:USERPROFILE\volume\mysql,dst=/var/lib/mysql `
        mysql:8.0.21
}

function New-DockerRunMySQL5 {
    docker run `
        --detach `
        --name mysql5 `
        --publish 3306:3306 `
        --env MYSQL_ROOT_PASSWORD="$password" `
        --env PGDATA=/var/lib/postgresql/data/pgdata `
        --mount type=bind,src=$env:USERPROFILE\volume\mysql,dst=/var/lib/mysql `
        mysql:5.7.31
}

######################################################################

New-DockerRunMySQL8
# New-DockerRunMySQL5
