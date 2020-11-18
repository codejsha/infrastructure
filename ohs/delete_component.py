#!/usr/bin/env python

oracle_home = os.environ['ORACLE_HOME']
domain_name = os.environ['DOMAIN_NAME']
domain_home = os.environ['DOMAIN_HOME']
component_name = os.environ['COMPONENT_NAME']

######################################################################

readDomain(domain_home)

cd('/')
delete(component_name, 'SystemComponent')

updateDomain()
closeDomain()

exit()
