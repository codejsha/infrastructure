#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

PASSWORD="${PASSWORD}"

git clone https://github.com/oracle/docker-images.git
# gh repo clone oracle/docker-images

cd docker-images/OracleDatabase/SingleInstance/dockerfiles

######################################################################

function docker_run_oracledb11 {
    /bin/cp -f /mnt/share/oracle-database/11gr2/oracle-xe-11.2.0-1.0.x86_64.rpm.zip 11.2.0.2
    bash ./buildDockerImage.sh -v 11.2.0.2 -x -i
    rm -f 11.2.0.2/*.zip

    sudo mkdir -p /mnt/volume/oracledb11
    sudo chmod 777 /mnt/volume/oracledb11

    docker container run \
        --detach \
        --name oracledb11 \
        --shm-size=1g \
        --publish 1521:1521 \
        --publish 5500:8080 \
        --env ORACLE_PWD="${PASSWORD}" \
        --mount type=bind,src=/mnt/volume/oracledb11,dst=/u01/app/oracle/oradata \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        oracle/database:11.2.0.2-xe
}

function docker_run_oracledb12_r1 {
    /bin/cp -f /mnt/share/oracle-database/12cr1/linuxamd64_12102_database_1of2.zip 12.1.0.2
    /bin/cp -f /mnt/share/oracle-database/12cr1/linuxamd64_12102_database_2of2.zip 12.1.0.2
    bash ./buildDockerImage.sh -v 12.1.0.2 -e -i
    rm -f 12.1.0.2/*.zip

    sudo mkdir -p /mnt/volume/oracledb12
    sudo chmod 777 /mnt/volume/oracledb12

    docker container run \
        --detach \
        --name oracledb12 \
        --publish 1521:1521 \
        --publish 5500:5500 \
        --env ORACLE_SID=ORCLCDB \
        --env ORACLE_PDB=ORCLPDB1 \
        --env ORACLE_PWD="${PASSWORD}" \
        --env ORACLE_CHARACTERSET=AL32UTF8 \
        --mount type=bind,src=/mnt/volume/oracledb12,dst=/opt/oracle/oradata \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        oracle/database:12.1.0.2-ee
}

function docker_run_oracledb12_r2 {
    /bin/cp -f /mnt/share/oracle-database/12cr2/linuxx64_12201_database.zip 12.2.0.1
    bash ./buildDockerImage.sh -v 12.2.0.1 -e -i
    rm -f 12.2.0.1/*.zip

    sudo mkdir -p /mnt/volume/oracledb12
    sudo chmod 777 /mnt/volume/oracledb12

    docker container run \
        --detach \
        --name oracledb12 \
        --publish 1521:1521 \
        --publish 5500:5500 \
        --env ORACLE_SID=ORCLCDB \
        --env ORACLE_PDB=ORCLPDB1 \
        --env ORACLE_PWD="${PASSWORD}" \
        --env ORACLE_CHARACTERSET=AL32UTF8 \
        --mount type=bind,src=/mnt/volume/oracledb12,dst=/opt/oracle/oradata \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        oracle/database:12.2.0.1-ee
}

function docker_run_oracledb12_r2_official_volume {
    docker pull store/oracle/database-enterprise:12.2.0.1

    docker volume create oracledb12vol

    docker container run \
        --detach \
        --name oracledb12 \
        --publish 1521:1521 \
        --mount type=bind,src=oracledb12vol,dst=/ORCL \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        store/oracle/database-enterprise:12.2.0.1
}

function docker_run_oracledb12_r2_official {
    docker pull store/oracle/database-enterprise:12.2.0.1

    sudo mkdir -p /mnt/volume/oracledb12
    sudo chmod 777 /mnt/volume/oracledb12

    docker container run \
        --detach \
        --name oracledb12 \
        --publish 1521:1521 \
        --mount type=bind,src=/mnt/volume/oracledb12,dst=/ORCL \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        store/oracle/database-enterprise:12.2.0.1
}

function docker_run_oracledb18 {
    /bin/cp -f /mnt/share/oracle-database/18c/LINUX.X64_180000_db_home.zip 18.3.0
    bash ./buildDockerImage.sh -v 18.3.0 -e -i
    rm -f 18.3.0/*.zip

    sudo mkdir -p /mnt/volume/oracledb18
    sudo chmod 777 /mnt/volume/oracledb18

    docker container run \
        --detach \
        --name oracledb18 \
        --publish 1521:1521 \
        --publish 5500:5500 \
        --env ORACLE_SID=ORCLCDB \
        --env ORACLE_PDB=ORCLPDB1 \
        --env ORACLE_PWD="${PASSWORD}" \
        --env ORACLE_CHARACTERSET=AL32UTF8 \
        --mount type=bind,src=/mnt/volume/oracledb18,dst=/opt/oracle/oradata \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        oracle/database:18.3.0-ee
}

function docker_run_oracledb19 {
    /bin/cp -f /mnt/share/oracle-database/19c/LINUX.X64_193000_db_home.zip 19.3.0
    bash ./buildDockerImage.sh -v 19.3.0 -e -i
    rm -f 19.3.0/*.zip

    sudo mkdir -p /mnt/volume/oracledb19
    sudo chmod 777 /mnt/volume/oracledb19

    docker container run \
        --detach \
        --name oracledb19 \
        --publish 1521:1521 \
        --publish 5500:5500 \
        --env ORACLE_SID=ORCLCDB \
        --env ORACLE_PDB=ORCLPDB1 \
        --env ORACLE_PWD="${PASSWORD}" \
        --env ORACLE_CHARACTERSET=AL32UTF8 \
        --mount type=bind,src=/mnt/volume/oracledb19,dst=/opt/oracle/oradata \
        --mount type=bind,src=/mnt/share,dst=/mnt/share \
        --mount type=bind,src=/mnt/storage,dst=/mnt/storage \
        oracle/database:19.3.0-ee
}

######################################################################

# docker_run_oracledb11
# docker_run_oracledb12_r1
# docker_run_oracledb12_r2
# docker_run_oracledb12_r2_official_volume
# docker_run_oracledb12_r2_official
# docker_run_oracledb18
docker_run_oracledb19
