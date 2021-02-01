# Oracle Database

- https://github.com/oracle/docker-images

## Get JDBC driver version info

### Using java

```bash
${JAVA_HOME}/bin/java -jar ${JDBC_DRIVER_FILE} -getversion
```

ojdbc6.jar:

```txt
Oracle 11.2.0.3.0 JDBC 4.0 compiled with JDK6 on Fri_Nov_04_08:05:20_PDT_2011
#Default Connection Properties Resource
#Mon Jul 09 17:51:57 KST 2018
```

ojdbc8.jar:

```txt
Oracle 12.2.0.1.0 JDBC 4.2 compiled with javac 1.8.0_91 on Tue_Dec_13_06:08:31_PST_2016
#Default Connection Properties Resource
#Fri Sep 28 10:34:57 KST 2018
```

### Using unzip

```bash
unzip -p ${JDBC_DRIVER_FILE} META-INF/MANIFEST.MF
```

ojdbc6.jar:

```txt
Manifest-Version: 1.0
Ant-Version: Apache Ant 1.6.5
Created-By: 1.5.0_30-b03 (Sun Microsystems Inc.)
Implementation-Vendor: Oracle Corporation
Implementation-Title: JDBC
Implementation-Version: 11.2.0.3.0
Repository-Id: JAVAVM_11.2.0.3.0AS11.1.1.6.0_LINUX.X64_111104
Specification-Vendor: Sun Microsystems Inc.
Specification-Title: JDBC
Specification-Version: 4.0
Main-Class: oracle.jdbc.OracleDriver
sealed: true

// ...
```

ojdbc8.jar:

```txt
Manifest-Version: 1.0
Ant-Version: Apache Ant 1.7.1
Implementation-Title: JDBC
Implementation-Version: 12.2.0.1.0
sealed: true
Repository-Id: JAVAVM_12.2.0.1.0_LINUX.X64_161213
Specification-Vendor: Sun Microsystems Inc.
Specification-Title: JDBC
Created-By: 25.91-b14 (Oracle Corporation)
Specification-Version: 4.0
Implementation-Vendor: Oracle Corporation
Main-Class: oracle.jdbc.OracleDriver

// ...
```
