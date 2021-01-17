# Tomcat

## Install

```bash
### pre-install
bash ./helper.sh

### install
bash ./install-tomcat.sh
```

### Create instances

- [Instance README](/tomcat/instance/README.md)

## Logging

[debug.sh](/tomcat/debug.sh)

- https://tomcat.apache.org/tomcat-9.0-doc/cluster-howto.html
- https://tomcat.apache.org/tomcat-9.0-doc/logging.html

### Log4j

- [Log4j README](/tomcat/log4j/README.md)
- [debug.xml](/tomcat/log4j/debug.xml)

## Datasource

### DBCP

- https://tomcat.apache.org/tomcat-9.0-doc/jndi-datasource-examples-howto.html
- https://commons.apache.org/proper/commons-dbcp/configuration.html

### HikariCP

- https://github.com/brettwooldridge/HikariCP/wiki/JNDI-DataSource-Factory-(Tomcat,-etc.)

## Deployment descriptor (web.xml)

[web.xml](/tomcat/instance/web.xml)

- https://cloud.google.com/appengine/docs/standard/java/config/webxml
- https://docs.spring.io/spring/docs/current/spring-framework-reference/core.html

cf. [weblogic/web.xml](/weblogic/web.xml)
