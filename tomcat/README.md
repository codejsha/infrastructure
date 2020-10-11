# Tomcat

## Logging

```properties
java.util.logging.ConsoleHandler.level = FINEST

### session
org.apache.catalina.session.level = FINEST

### cluster
org.apache.catalina.tribes.level = FINEST
```

- https://tomcat.apache.org/tomcat-9.0-doc/cluster-howto.html
- https://tomcat.apache.org/tomcat-9.0-doc/logging.html

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
