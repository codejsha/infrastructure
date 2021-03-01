######################################################################

### connect
mysqlsh root:password@test.example.com:3306/mysql --sql
mysqlsh root@test.example.com:3306/mysql --password=password --sql
mysqlsh --user=root --password=password --host=test.example.com --port=3306 --database=mysql --sql

######################################################################

### security
/usr/bin/mysql_secure_installation

### Enter current password for root (enter for none): [ENTER]
### New password: [PASSWORD]
### Re-enter new password: [PASSWORD]
### Set root password? [Y/n] Y
### Remove anonymous users? [Y/n] Y
### Disallow root login remotely? [Y/n] Y
### Remove test database and access to it? [Y/n] Y
### Reload privilege tables now? [Y/n] Y
