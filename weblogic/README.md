# WebLogic

## Sample Application

Add 'WebLogic Server/Server Examples' component to COMPONENT_PATHS in [silent.xml](/weblogic/silent.xml)

```xml
        <data-value name="COMPONENT_PATHS" value="WebLogic Server/Core Application Server|WebLogic Server/Administration Console|WebLogic Server/Configuration Wizard and Upgrade Framework|WebLogic Server/Web 2.0 HTTP Pub-Sub Server|WebLogic Server/WebLogic JDBC Drivers|WebLogic Server/Third Party JDBC Drivers|WebLogic Server/WebLogic Server Clients|WebLogic Server/WebLogic Web Server Plugins|WebLogic Server/UDDI and Xquery Support|WebLogic Server/Server Examples" />
```

And then, install weblogic.

```bash
bash install-weblogic.sh
```

For convenience, add symbolic links.

```bash
# ln -snf ${DOMAIN_HOME} ${ORACLE_HOME}/${DOMAIN_NAME}

ORACLE_HOME="/usr/local/weblogic"
ln -snf ${ORACLE_HOME}/wlserver_10.3/samples/domains/wl_server ${ORACLE_HOME}/wl_server
ln -snf ${ORACLE_HOME}/wlserver_10.3/samples/domains/medrec ${ORACLE_HOME}/medrec
ln -snf ${ORACLE_HOME}/wlserver_10.3/samples/domains/medrec-spring ${ORACLE_HOME}/medrec-spring
```
