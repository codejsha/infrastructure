#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR

NAMESPACE="confluent-operator"
LABEL="${1}"
ELAPSED_TIME="0"
MAX_ELAPSED_TIME="600"
INTERVAL_SECONDS="10"

while [ "${ELAPSED_TIME}" -lt "${MAX_ELAPSED_TIME}" ]; do
    IS_POD_READY_ARR="$(kubectl get pods --namespace ${NAMESPACE} --selector ${LABEL} --output 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')"
    # IS_POD_READY_ARR="$(oc get pods --namespace ${NAMESPACE} --selector ${LABEL} --output 'jsonpath={..status.conditions[?(@.type=="Ready")].status}')"
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
    sleep ${INTERVAL_SECONDS}
done

if [ "${ELAPSED_TIME}" -ge "${MAX_ELAPSED_TIME}" ]; then
    echo "[ERROR] Max elapsed time timeout!"
    echo "[ERROR] All pods are not ready!"
    echo
    return 1
fi

echo
