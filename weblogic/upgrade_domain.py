#!/usr/bin/env python

domainlist = ['base_domain1', 'base_domain2', 'base_domain3']

for domain in domainlist:
    readDomainForUpgrade('/usr/local/weblogic/user_projects/domains/' + domain)
    updateDomain()
    closeDomain()
exit()
