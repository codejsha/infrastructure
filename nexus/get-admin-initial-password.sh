#!/bin/bash

NEXUS_PODNAME="$(kubectl get pods -l app=sonatype-nexus -o custom-columns=:metadata.name)"

kubectl exec ${NEXUS_PODNAME} -c nexus -- cat /nexus-data/admin.password && echo ""
