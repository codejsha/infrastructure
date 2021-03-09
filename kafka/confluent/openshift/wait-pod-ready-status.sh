#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

NAMESPACE="confluent-operator"
LABEL="${1}"
ELAPSED_TIME="0"
ELAPSED_MAX_TIME="600"

while [ "${ELAPSED_TIME}" -lt "${ELAPSED_MAX_TIME}" ]; do
    # IS_POD_READY_ARR="$(kubectl get po -n ${NAMESPACE} -l ${LABEL} -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')"
    IS_POD_READY_ARR="$(oc get po -n ${NAMESPACE} -l ${LABEL} -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')"
    ALL_POD_READY="True"

    if [ -z "${IS_POD_READY_ARR}" ]; then
        ALL_POD_READY="False"
    fi

    for IS_POD_READY in ${IS_POD_READY_ARR[@]}; do
        if [ "${IS_POD_READY}" == "False" ]; then
            ALL_POD_READY="False"
        fi
    done

    if [ "${ALL_POD_READY}" == "True" ]; then
        echo "[INFO] All pods are ready (${LABEL})."
        break;
    fi

    echo "[INFO] Waiting for all pods to be ready (${LABEL})..."
    ELAPSED_TIME="$(( ${ELAPSED_TIME} + 10 ))"
    sleep 10
done

if [ "${ELAPSED_TIME}" -ge "${ELAPSED_MAX_TIME}" ]; then
    echo "[ERROR] Elapsed max time timeout!"
    echo "[ERROR] All pods are not ready!"
    echo
    return 1
fi

echo
