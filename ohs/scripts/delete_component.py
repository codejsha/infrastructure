#!/usr/bin/env python

oracle_home = '/usr/local/ohs'
domain_name = 'base_domain'
domain_home = oracle_home + '/user_projects/domains/' + domain_name
component_name = 'ohs1'

######################################################################

readDomain(domain_home)

cd('/')
delete(component_name, 'SystemComponent')

updateDomain()
closeDomain()

exit()
