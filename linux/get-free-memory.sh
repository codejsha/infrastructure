#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

######################################################################

function get-free-memory {
    # free -t
    free --total
}

function get-free-memory-human-readable {
    # free -th
    free --total --human
}

function get-free-memory-low-high-statistics {
    # free -thl
    free --total --human --lohi
}

function get-free-memory-repeat {
    SECONDS="3"
    COUNT=="5"

    # free -th -s ${SECONDS} -c ${COUNT}
    free --total --human --seconds ${SECONDS} --count ${COUNT}
}

######################################################################

# get-free-memory
get-free-memory-human-readable
# get-free-memory-low-high-statistics
# get-free-memory-repeat
