#!/bin/bash

FILE=${1}
if [[ -z "${FILE}" ]] || [[ ! -f "${FILE}" ]]; then
    FILE=$(ls $(date +%Y-%m-%d)* 2>/dev/null)
fi
if [[ -z "${FILE}" ]]; then
    echo Unable to determine file
    exit 1
fi

INCLUDES=$(xmlstarlet sel -N x="http://www.w3.org/1999/xhtml" -t -m "//x:section/@data-markdown" -v . -n "${FILE}" | grep -vE '^$')
DIRS=$(for INCLUDE in ${INCLUDES}; do echo $(dirname ${INCLUDE}); done)

for DIR in ${DIRS}; do
    if test -f "${PWD}/${DIR}/prep.sh"; then
        echo "### Preparing ${DIR}"
        ssh docker-hcloud bash < "${PWD}/${DIR}/prep.sh"
    fi
    if test -f "${PWD}/${DIR}/user-data.txt"; then
        echo "### Deploying VM for ${DIR}"
        NAME=${DIR////-}
        NAME=${NAME//_/}
        echo "    Name=${NAME}"
        hcloud server create \
            --name ${NAME} \
            --location fsn1 \
            --image ubuntu-18.04 \
            --ssh-key 209622 \
            --type cx21 \
            --user-data-from-file "${PWD}/${DIR}/user-data.txt"
    fi
done
