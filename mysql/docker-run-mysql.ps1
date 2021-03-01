$password = "$password"

# $MySQLVolumeDir="C:\volume\mysql"
$MySQLVolumeDir="$env:USERPROFILE\volume\mysql"
New-Item -Path $MySQLVolumeDir -ItemType Directory -Force

######################################################################

function New-DockerRunMySQL8 {
    docker container run `
        --detach `
        --name mysql8 `
        --publish 3306:3306 `
        --publish 33060:33060 `
        --env MYSQL_ROOT_PASSWORD="$password" `
        --env PGDATA=/var/lib/postgresql/data/pgdata `
        --mount type=bind,src=$MySQLVolumeDir,dst=/var/lib/mysql `
        mysql:8.0.23
}

function New-DockerRunMySQL5 {
    docker container run `
        --detach `
        --name mysql5 `
        --publish 3306:3306 `
        --publish 33060:33060 `
        --env MYSQL_ROOT_PASSWORD="$password" `
        --env PGDATA=/var/lib/postgresql/data/pgdata `
        --mount type=bind,src=$MySQLVolumeDir,dst=/var/lib/mysql `
        mysql:5.7.33
}

######################################################################

New-DockerRunMySQL8
# New-DockerRunMySQL5
