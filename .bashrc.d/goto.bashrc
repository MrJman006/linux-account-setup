function goto()
{
    #
    # Check for usage option.
    #

    local show_usage="no"
    
    
    if $(echo "$@" | grep -Pq "(^|\s+)(-h|--help)(\s+|$)")
    then
        show_usage="yes"
    fi

    if [[ "${show_usage}" == "yes" ]]
    then
        echo "MANUAL PAGE"
        echo "    goto"
        echo ""
        echo "USAGE"
        echo "    goto [options] [path|history-number]"
        echo ""
        echo "DESCRIPTION"
        echo "    goto is a tool to more easily navigate directories from the command line."
        echo "    It not only performs the same function as the traditional 'cd' command,"
        echo "    but supports adding and removing destinations to a history. Call goto"
        echo "    with a valid destination to navigate to it. Call goto without any path argument"
        echo "    to choose a destination from the history. Use the '--add' and '--delete'"
        echo "    options to modify the history."
        echo ""
        echo "OPTIONS"
        echo "    -h|--help"
        echo "        Show this manual page."
        echo ""
        echo "    -a|--add"
        echo "        Add a directory to the history."
        echo ""
        echo "    -d|--delete"
        echo "        Delete a directory form the history."
        echo ""
        echo "ARGUMENTS"
        echo "    [path]"
        echo "        A path to go to. If supplied with the '--add' or '--delete' flag,"
        echo "        the history will be modified instead."
        echo ""
        echo "    [history-number]"
        echo "        The history number to go to. If supplied with the '--add' or '--delete' flag,"
        echo "        the history will be modified instead."
        echo ""
        echo "END"

        return 1
    fi

    #
    # Parse options.
    #

    local -A options

    options[add]="no"
    options[delete]="no"
    options[interactive]="no"

    while [ 1 ]
    do
        local token="${1}"
        case "${token}" in
            -a|--add)
                shift
                options[add]="yes"
                ;;
            -d|--delete)
                shift
                options[delete]="yes"
                ;;
            --)
                shift
                ;;
            -?)
                echo "Invalid option '${token}'"
                return 1
                ;;
            *)
                break
                ;;
        esac
    done

    #
    # Parse arguments.
    #

    local arguments=("$@")

    #
    # Check for conflicting options.
    #

    if [[ "${options[add]}" == "yes" ]] && [[ "${options[delete]}" == "yes" ]]
    then
        echo "You cannot use '--add' and '--delete' together."
        return 1
    fi

    #
    # Create the history if it does not exist.
    #

    local temp_dir="/dev/shm/$(whoami)"
    mkdir -p "${temp_dir}"
    chmod 700 "${temp_dir}"

    temp_dir+="/goto"
    mkdir -p "${temp_dir}"

    local history_file="${temp_dir}/history"
    touch "${history_file}"

    #
    # Check if this is an interactive call.
    #

    local path

    if [[ ${#arguments[@]} -eq 0 ]]
    then
        options[interactive]="yes"
        path="$(pwd -P)"
    elif $(echo "${arguments[0]}" | grep -Pq "^[0-9]+$")
    then
        path="$(sort "${history_file}" | head -n ${arguments[0]} | tail -n 1)"
    elif [[ ! -d "${arguments[0]}" ]]
    then
        echo "Error: The supplied path is not a valid destination."
        return 1
    else
        path="$(cd "${arguments[0]}" && pwd -P)"
    fi

    #
    # Handle calls using the add option.
    #

    if [[ "${options[add]}" == "yes" ]]
    then
        if $(grep -Pq "^${path}$" "${history_file}")
        then
            return 0
        fi

        echo "${path}" 1>> "${history_file}"
        return 0
    fi

    #
    # Handle non-interactive calls.
    #

    if [[ "${options[interactive]}" == "no" ]]
    then 

        #
        # Remove the path from the history.
        #

        if [[ "${options[delete]}" == "yes" ]]
        then
            sed -r -i "\|${path}|d" "${history_file}"
            return 0
        fi 

        #
        # Go to the destination.
        #

        cd "${path}"
        return 0
    fi

    #
    # Handle interactive calls.
    #

    local prompt

    if [[ "${options[delete]}" == "yes" ]]
    then
        prompt="delete: "
    else
        prompt="goto: "
    fi

    sort "${history_file}" | grep -n ""

    local line_item

    read -p "${prompt}" line_item

    if ! $(echo "${line_item}" | grep -Pq "^[0-9]+$") ||
        [[ ${line_item} -lt 1 ]] ||
        [[ ${line_item} -gt $(cat "${history_file}" | wc -l) ]]
    then
        echo "Invalid selection."
        return 1
    fi

    if [[ "${options[delete]}" == "yes" ]]
    then
        sort "${history_file}" | sed -e "${line_item}d" 1> "${history_file}.new"
        mv "${history_file}.new" "${history_file}"
    else
        cd $(sort "${history_file}" | head -n ${line_item} | tail -n 1)
    fi
}
