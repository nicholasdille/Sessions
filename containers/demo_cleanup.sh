#!/bin/bash

. functions.sh

echo
echo -e "${YELLOW}Waiting for demo to end. Press enter to continue...${DEFAULT}"
read

for DIR in ${DIRS}; do
    echo
    echo -e "${YELLOW}### Cleaning up in ${DIR}${DEFAULT}"
    NAME=${DIR////-}
    NAME=${NAME//_/}
    if hcloud server list --selector demo=true,dir=${NAME} | grep --quiet "${NAME}"; then
        hcloud server delete ${NAME}
    fi
done

hcloud ssh-key delete demo
rm id_rsa_demo*
