#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NEXUS_PODNAME="$(kubectl get pods -l app=sonatype-nexus -o custom-columns=:metadata.name)"

kubectl exec ${NEXUS_PODNAME} -c nexus -- cat /nexus-data/admin.password && echo ""
