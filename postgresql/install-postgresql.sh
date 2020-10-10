#!/usr/bin/bash
# https://www.postgresql.org/download/linux/redhat/

######################################################################

### CentOS 7

POSTGRESQL_VERSION="13"

# Install the repository RPM:
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

# Install PostgreSQL:
sudo yum install -y postgresql${POSTGRESQL_VERSION}-server

# Optionally initialize the database and enable automatic start:
# /usr/pgsql-${POSTGRESQL_VERSION}/bin/postgresql-${POSTGRESQL_VERSION}-setup initdb
# sudo systemctl enable postgresql-${POSTGRESQL_VERSION}
# sudo systemctl start postgresql-${POSTGRESQL_VERSION}

######################################################################

### CentOS 8

POSTGRESQL_VERSION="13"

# # Install the repository RPM:
# dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
#
# # Disable the built-in PostgreSQL module:
# dnf -qy module disable postgresql
#
# # Install PostgreSQL:
# dnf install -y postgresql${POSTGRESQL_VERSION}-server
#
# # Optionally initialize the database and enable automatic start:
# /usr/pgsql-${POSTGRESQL_VERSION}/bin/postgresql-${POSTGRESQL_VERSION}-setup initdb
# systemctl enable postgresql-${POSTGRESQL_VERSION}
# systemctl start postgresql-${POSTGRESQL_VERSION}
