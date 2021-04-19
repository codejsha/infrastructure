######################################################################

### interface
/interface=management:write-attribute(name=inet-address,value=${jboss.bind.address.management:127.0.0.1})
/interface=private:write-attribute(name=inet-address,value=${jboss.bind.address:127.0.0.1})
/interface=public:write-attribute(name=inet-address,value=${jboss.bind.address:127.0.0.1})

######################################################################

### jdr report
${JBOSS_HOME}/bin/jdr.sh --host ${BIND_ADDRESS_MGMT} --port ${JBOSS_MGMT_HTTP_PORT} --config ${SERVER_CONFIG_FILE}
${JBOSS_HOME}/bin/jdr.sh --host test.example.com --port 9990 --config standalone-ha.xml
