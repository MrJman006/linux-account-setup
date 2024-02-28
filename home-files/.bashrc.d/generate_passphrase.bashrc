function generate_passphrase()
{
    local show_usage="no"

    echo "$@" | grep -Pq "(^|\s+)(-h|--help)(\s+|$)"
    if [[ $? -eq 0 ]]
    then
        show_usage="yes"
    fi

    if [[ "${show_usage}" == "yes" ]]
    then
        echo "usage: generate_passphrase [-h|--help] [length]"
        echo ""
        echo "    length"
        echo "        The raw passphrase length to generate. The default is length is 16." 
        return 1
    fi

    local length=16

    if [[ $# -eq 1 ]]
    then
        length=$(( ${1} ))
    fi

    local raw_passphrase="$(cat /dev/urandom | tr -dc a-z | head -c "${length}")"
    local formatted_passphrase="$(echo "${raw_passphrase}" | sed -r -e "s/([a-z]{4})/\1-/g" -e "s/-$//")"

    printf "%-21s: %s\n" "Raw Passphrase" "${raw_passphrase}"
    printf "%-21s: %s\n" "Formatted Passphrase" "${formatted_passphrase}"
}
