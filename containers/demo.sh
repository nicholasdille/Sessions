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
echo "### Creating new SSH key"
if [[ ! -f id_rsa_demo ]]; then
    ssh-keygen -f id_rsa_demo -N ""
fi
hcloud ssh-key create --name demo --public-key-from-file id_rsa_demo.pub
echo "    Done."

INCLUDES=$(xmlstarlet sel -N x="http://www.w3.org/1999/xhtml" -t -m "//x:section/@data-markdown" -v . -n "${FILE}" | grep -vE '^$')
DIRS=$(for INCLUDE in ${INCLUDES}; do echo $(dirname ${INCLUDE}); done)

DIRS=$(echo "${DIRS}" | while read DIR; do if [[ "$(ls ${DIR}/*.demo 2>/dev/null)" != "" ]]; then echo ${DIR}; fi; done)

for DIR in ${DIRS}; do
    echo
    echo "### Preparing ${DIR}"

    for FILE in $(ls ${DIR}/*.demo); do
        DEMO=$(basename ${FILE} .demo)
        echo "    Splitting demo ${DEMO}"
        (cd ${DIR}; split ${DEMO})
    done

    NAME=docker-hcloud
    if test -f "${PWD}/${DIR}/user-data.txt"; then
        echo "    Deploying VM"
        NAME=${DIR////-}
        NAME=${NAME//_/}
        echo "    Name=${NAME}"
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
        echo "    Installing tools"
        # TODO: Decide where to install the tools
        #ssh ${NAME} bash < "${PWD}/${DIR}/prep.sh"
        ssh docker-hcloud bash < "${PWD}/${DIR}/prep.sh"
        #bash "${PWD}/${DIR}/prep.sh"
    fi

    echo "    Done."
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

    echo "Adding SSH configuration for <${SERVER_NAME}> at <${SERVER_IP}>"

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

echo
echo "Waiting for demo to start. Press enter to continue..."
read

for DIR in ${DIRS}; do
    pushd ${PWD}
    clear
    echo -e "\e[93m### Demo for ${DIR}\e[39m"
    NAME=${DIR////-}
    NAME=${NAME//_/}
    if hcloud server list --selector demo=true,dir=${NAME} | grep --quiet "${NAME}"; then
        echo -e "\e[93m    VM ${NAME}\e[39m"
    fi
    echo
    cd "${PWD}/${DIR}"

    echo -e "\e[93m    Preparing demo\e[39m"
    prepare

    export SET_PROMPT=1
    bash --init-file ../../functions.sh
    unset SET_PROMPT

    echo -e "\e[93m    Cleaning up after demo\e[39m"
    clean

    popd
done

echo
echo "Waiting for demo to end. Press enter to continue..."
read

for DIR in ${DIRS}; do
    echo
    echo "### Cleaning up in ${DIR}"
    NAME=${DIR////-}
    NAME=${NAME//_/}
    if hcloud server list --selector demo=true,dir=${NAME} | grep --quiet "${NAME}"; then
        hcloud server delete ${NAME}
    fi
done

hcloud ssh-key delete demo
rm id_rsa_demo*
