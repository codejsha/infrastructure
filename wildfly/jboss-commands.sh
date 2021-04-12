######################################################################

### interface
/interface=management:write-attribute(name=inet-address,value=${jboss.bind.address.management:127.0.0.1})
/interface=private:write-attribute(name=inet-address,value=${jboss.bind.address:127.0.0.1})
/interface=public:write-attribute(name=inet-address,value=${jboss.bind.address:127.0.0.1})
