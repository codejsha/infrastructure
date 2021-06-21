#!/bin/bash
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: status ${?}: user ${USER}: func ${FUNCNAME[0]}"' ERR
set -o errexit
set -o errtrace

######################################################################

function tidy_indent {
    local XML_FILE="${1}"

    tidy -modify \
        --indent true --indent-spaces 4 --indent-attributes true \
        --input-xml true --output-xml true \
        --hide-comments true --quote-nbsp false \
        --quiet true --wrap 80 \
        ${XML_FILE}
}

function tidy_nowrap {
    local XML_FILE="${1}"

    tidy -modify \
        --indent true --indent-spaces 4 --indent-attributes false \
        --input-xml true --output-xml true \
        --hide-comments true --quote-nbsp false \
        --quiet true --wrap 0 \
        ${XML_FILE}
}
