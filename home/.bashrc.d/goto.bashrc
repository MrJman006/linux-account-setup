function jcd_goto()
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
        echo "    but supports adding and removing destinations to a temporary history"
        echo "    similar to 'pushd' and 'popd' or a perminant bookmark history."
        echo ""
        echo "    There are several ways to call goto. The first is to call it with the"
        echo "    '--add' option to save a destination to the goto history. Supply a"
        echo "    valid destination as an argument to save the destination to the history"
        echo "    If no argument is passed the current working directory will be added"
        echo "    to the goto history."
        echo ""
        echo "        goto --add /usr/local/bin"
        echo "        goto --add"
        echo ""
        echo "    Use the '--bookmark' option to save the destination to the goto bookmarks."
        echo ""
        echo "        goto --bookmark /usr/local/bin"
        echo "        goto --bookmark"
        echo ""
        echo "    Use the '--delete' option to remove the destination from both the goto"
        echo "    bookmarks and history. The destination can be either a path string or"
        echo "    the history or bookmark identifier. If you supply a history or bookmark"
        echo "    identifier, it will only be removed from the associated store."
        echo ""
        echo "        goto --delete /usr/local/bin"
        echo "        goto --delete h1
        echo "        goto --delete b1
        echo "        goto --delete"
        echo ""
        echo "    Call goto without any options to navigate to a destination. If you"
        echo "    supply a destination argument, history identifier, or bookmark identifier,"
        echo "    you will navigate to the associated destination."
        echo ""
        echo "        goto /usr/local/bin"
        echo "        goto h1"
        echo "        goto b1"
        echo ""
        echo "    Calling goto without any argument will enable interactive destination"
        echo "    selection."
        echo ""
        echo "        goto"
        echo ""
        echo "OPTIONS"
        echo "    -h|--help"
        echo "        Show this manual page."
        echo ""
        echo "    -a|--add"
        echo "        Add a destination to the history destination list."
        echo ""
        echo "    -b|--bookmark"
        echo "        Add a destination to the bookmark destination list."
        echo ""
        echo "    -d|--delete"
        echo "        Delete a destination from one or both of the history and/or bookmark"
        echo "        destination list."
        echo ""
        echo "ARGUMENTS"
        echo "    [destination_path]"
        echo "        A destination to go to. If used with the '--add' or '--bookmark' option,"
        echo "        the destination will be added to the approprite destination list. If"
        echo "        used with the '--delete' option, the destination will be removed"
        echo "        from all destination lists.
        echo ""
        echo "    [id]"
        echo "        A history or bookmark ID to go to. If used with the '--delete'"
        echo "        option the ID will be removed from the associated destination"
        echo "        list."
        echo ""
        echo "END"

        return 1
    fi

    #
    # Parse options.
    #

    local -A options

    options[add]="no"
    options[bookmark]="no"
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
            -b|--bookmark)
                shift
                options[bookmark]="yes"
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
