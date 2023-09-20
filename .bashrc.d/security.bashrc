gen_passphrase()
{
    echo "$@" | grep -Pq "(^|\s+)(-h|--help)(\s+|$)"
    if [[ $? -eq 0 ]]
    then
        echo "usage: gen_passphrase [--help] [length]"
        exit 1
    fi

    local length=16

    if [ $# -eq 1 ]
    then
        length=$(( ${1} ))
    fi

    local raw_passphrase="$(cat /dev/urandom | tr -dc a-z | head -c "${LENGTH}")"
    local formatted_passphrase="$(echo "${RAW_PASSPHRASE}" | sed -r -e "s/([a-z]{4})/\1-/g" -e "s/-$//")"

    echo "${raw_passphrase}"
    echo "${formatted_passphrase}"
}
