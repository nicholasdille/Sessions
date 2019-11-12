#!/bin/bash

. functions.sh

FILE=${1}
if [[ -z "${FILE}" ]] || [[ ! -f "${FILE}" ]]; then
    FILE=$(ls $(date +%Y-%m-%d)* 2>/dev/null)
fi
if [[ -z "${FILE}" ]]; then
    echo Unable to determine file
    exit 1
fi

if ! type jq; then
    apt install jq
fi
if ! type xmlstarlet; then
    apt install xmlstarlet
fi
if ! type hcloud; then
    curl -sLf https://github.com/hetznercloud/cli/releases/download/v1.13.0/hcloud-linux-amd64-v1.13.0.tar.gz | tar -xvz -C /usr/local/bin/ --strip-components=2 hcloud-linux-amd64-v1.13.0/bin/hcloud hcloud-linux-amd64-v1.13.0/bin/hcloud
fi

echo
echo -e "${YELLOW}### Creating new SSH key${DEFAULT}"
if [[ ! -f id_rsa_demo ]]; then
    ssh-keygen -f id_rsa_demo -N ""
fi
hcloud ssh-key create --name demo --public-key-from-file id_rsa_demo.pub
echo -e "${YELLOW}    Done.${DEFAULT}"

INCLUDES=$(xmlstarlet sel -N x="http://www.w3.org/1999/xhtml" -t -m "//x:section/@data-markdown" -v . -n "${FILE}" | grep -vE '^$')
DIRS=$(for INCLUDE in ${INCLUDES}; do echo $(dirname ${INCLUDE}); done)

DIRS=$(echo "${DIRS}" | while read DIR; do if [[ "$(ls ${DIR}/*.demo 2>/dev/null)" != "" ]]; then echo ${DIR}; fi; done)

for DIR in ${DIRS}; do
    if [[ "$(ls ${DIR}/*.demo 2>/dev/null)" == "" ]]; then
        echo
        echo -e "${RED}No demos in ${DIR}${DEFAULT}"
    fi

    echo
    echo -e "${YELLOW}### Preparing ${DIR}${DEFAULT}"

    for FILE in $(ls ${DIR}/*.demo >/dev/null); do
        DEMO=$(basename ${FILE} .demo)
        echo -e "${YELLOW}    Splitting demo ${DEMO}${DEFAULT}"
        (cd ${DIR}; split ${DEMO})
    done

    NAME=docker-hcloud
    if test -f "${PWD}/${DIR}/user-data.txt"; then
        echo -e "${YELLOW}    Deploying VM${DEFAULT}"
        NAME=${DIR////-}
        NAME=${NAME//_/}
        echo -e "${YELLOW}    Name=${NAME}${DEFAULT}"
        if ! hcloud server list --selector demo=true,dir=${NAME} | grep --quiet "${NAME}"; then
            hcloud server create \
                --name ${NAME} \
                --location fsn1 \
                --image ubuntu-18.04 \
                --ssh-key demo \
                --type cx21 \
                --user-data-from-file "${PWD}/${DIR}/user-data.txt"
            hcloud server add-label ${NAME} demo=true
            hcloud server add-label ${NAME} dir=${NAME}
        fi
    fi

    if test -f "${PWD}/${DIR}/prep.sh"; then
        echo -e "${YELLOW}    Installing tools"
        # TODO: Decide where to install the tools
        #ssh ${NAME} bash < "${PWD}/${DIR}/prep.sh"
        ssh docker-hcloud bash < "${PWD}/${DIR}/prep.sh"
        #bash "${PWD}/${DIR}/prep.sh"
    fi

    echo -e "${YELLOW}    Done.${DEFAULT}"
done

mkdir -p ~/.ssh/config.d
if ! test -f ~/.ssh/config; then
    cat > ~/.ssh/config <<EOF
Include config.d/*
EOF
fi
rm -f ~/.ssh/config.d/hcloud_*
hcloud server list -o columns=name,ipv4 | tail -n +2 | while read LINE
do
    SERVER_NAME=$(echo $LINE | awk '{print $1}')
    SERVER_IP=$(echo $LINE | awk '{print $2}')

    echo -e "${YELLOW}Adding SSH configuration for <${SERVER_NAME}> at <${SERVER_IP}>${DEFAULT}"

    cat > ~/.ssh/config.d/hcloud_${SERVER_NAME} <<EOF
Host ${SERVER_NAME} ${SERVER_IP}
    HostName ${SERVER_IP}
    User root
    IdentityFile ~/id_rsa_hetzner
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF
    chmod 0640 ~/.ssh/config.d/hcloud_${SERVER_NAME}
done
