#!/bin/bash

FILE=${1}
if [[ -z "${FILE}" ]] || [[ ! -f "${FILE}" ]]; then
    FILE=$(ls $(date +%Y-%m-%d)* 2>/dev/null)
fi
if [[ -z "${FILE}" ]]; then
    echo Unable to determine file
    exit 1
fi

if ! type xmlstarlet; then
    apt install xmlstarlet
fi
if ! type hcloud; then
    curl -sLf https://github.com/hetznercloud/cli/releases/download/v1.13.0/hcloud-linux-amd64-v1.13.0.tar.gz | tar -xvz -C /usr/local/bin/ --strip-components=2 hcloud-linux-amd64-v1.13.0/bin/hcloud hcloud-linux-amd64-v1.13.0/bin/hcloud
fi

INCLUDES=$(xmlstarlet sel -N x="http://www.w3.org/1999/xhtml" -t -m "//x:section/@data-markdown" -v . -n "${FILE}" | grep -vE '^$')
DIRS=$(for INCLUDE in ${INCLUDES}; do echo $(dirname ${INCLUDE}); done)

for DIR in ${DIRS}; do
    echo
    echo "### Preparing ${DIR}"

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
                --ssh-key 209622 \
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
        #ssh docker-hcloud bash < "${PWD}/${DIR}/prep.sh"
        bash "${PWD}/${DIR}/prep.sh"
    fi

    echo "    Done."
done

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
    echo "### Demo for ${DIR}"
    NAME=${DIR////-}
    NAME=${NAME//_/}
    if hcloud server list --selector demo=true,dir=${NAME} | grep --quiet "${NAME}"; then
        echo "    VM ${NAME}"
    fi
    echo
    cd "${PWD}/${DIR}"
    bash
    #cat slides.md | sed -n '/^```/,/^```/ p' | grep -vE '^```$' | csplit - '/```bash/' {*} --prefix=slides.md.bash. --elide-empty-files --quiet
    #for FILE in $(ls slides.md.bash.*); do
    #    echo
    #    COMMANDS=$(cat ${FILE} | grep -v '^```bash$')
    #    echo ${COMMANDS}
    #    echo
    #    echo "Do you want to execute this (Y/n)?"
    #    read -N 1 REPLY
    #    if test "${REPLY}" == "" || test "${REPLY}" == "y"; then
    #        eval ${COMMANDS}
    #    fi
    #done
    #rm slides.md.bash.*
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
    hcloud server delete ${NAME}
done
