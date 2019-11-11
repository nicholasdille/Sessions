if [[ "${SET_PROMPT}" == "1" ]]; then
    export PS1='\w $ '
    export PROMPT_DIRTRIM=2
fi

demos() {
    DEMOS=$(ls -1 *.demo 2>/dev/null)
    if [[ -n "${DEMOS}" ]]; then
        echo
        echo "${DEMOS}" | while read FILE; do echo $(basename ${FILE} .demo): $(cat ${FILE} | head -n 1); done
        echo
    fi
}

demo() {
    if [[ "$#" == "0" ]]; then
        echo "Usage: $0 <demo_name>"
        return
    fi
    DEMO=${1}

    clear
    for COMMAND in $(ls ${DEMO}-*.command); do
        echo
        cat ${COMMAND} | grep -vE '^\s*$' | while read LINE; do echo -e "$ \e[92m${LINE}\e[39m"; done
        read KEY
        . ${COMMAND}
        if [[ "$?" != 0 ]]; then
            echo
            echo "Command failed stopping demo"
            break
        fi
        echo
    done
    echo
}

prepare() {
    if [[ -f prepare.sh ]]; then
        bash prepare.sh
    fi
}

clean() {
    docker ps -aq | xargs -r docker rm -f >/dev/null
    docker system prune --all --volumes --force >/dev/null

    if [[ -f clean.sh ]]; then
        bash clean.sh
    fi
}

split() {
    if [[ "$#" == "0" ]]; then
        echo "Usage: $0 <demo_name>"
        return
    fi
    DEMO=${1}

    cat ${DEMO}.demo | tail -n +2 | grep -vE '^\s*$' | csplit --prefix ${DEMO}- --suffix-format '%01d.command' --elide-empty-files --quiet - '/^#/' {*}
}

include() {
    PATTERN="^\s*<!--\s*include\:\s*(.+\.command)\s*-->\s*$"
    cat slides.md | while read LINE; do
		if [[ ${LINE} =~ ${PATTERN} ]]; then
			FILE=$(echo ${LINE} | sed -E "s/${PATTERN}/\1/")
            TEXT=$(cat ${FILE} | grep -E "^#" | head -n 1 | sed -E 's/^#\s*(.+)$/\1/')
            echo ${TEXT}:
            echo
            echo '```bash'
            cat ${FILE} | grep -vE "^\s*$" | grep -vE "^#"
            echo '```'
        else
            echo ${LINE}
		fi
	done >README.md
}