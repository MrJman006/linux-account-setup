#! /usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias xtrace_on='{ set -x; } 1>/dev/null 2>&1'
alias xtrace_off='{ set +x; } 1>/dev/null 2>&1'

readonly START_EXECUTION_TIMESTAMP="$(date +%Y-%m-%d-%H-%M-%S)"
readonly THIS_SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly THIS_SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

declare -a ARGUMENTS
declare -A OPTIONS
OPTIONS[NEED_HELP]="no"

MANUAL_PAGE_TEMPLATE="$(cat <<'EOF'
    MANUAL_PAGE
        @{SCRIPT_NAME}

    USAGE
        @{SCRIPT_NAME} [optons] [argument...]

    DESCRIPTION
        This script modifies GNOME settings so pressing 'alt + tab' cycles through
        individual windows instead of window groups.

    OPTIONS
        -h|--help
            Show this manual page.

    ARGUMENTS
        N/A

    END
EOF
)"

function parse_command_line()
{
    #
    # Parse options.
    #

    while [ $# -gt 0 ]
    do
        local opt="${1}"

        case "${opt}" in
            -h|--help)
                shift
                OPTIONS[NEED_HELP]="yes"
                return 0
                ;;
            --)
                shift
                break
                ;;
            -?*)
                log_error "Invalid option '${opt}'."
                abort
                ;;
            *)
                break
                ;;
        esac
    done

    #
    # Parse arguments.
    #

    ARGUMENTS=("$@")

    #
    # Check for required or unexpected positional arguments.
    #

    if [[ ${#ARGUMENTS[@]} -ne 0 ]]
    then
        log_error "Unexpected arguments detected."
        abort
    fi
}

function logit()
{
    local message="${@:-}"
    echo -e "${message[@]}" 1>&3
    echo -e "${message[@]}" | sed -r "s/[[:cntrl:]]\[([0-9]{1,3};)*[0-9]{1,3}m//g" 1>&4
}

function log_error()
{
    local message="${@:-}"
    echo -e "${RED_ON:-}Error: ${message[@]}${COLOR_OFF:-}" 1>&3
    echo -e "Error: ${message[@]}" | sed -r "s/[[:cntrl:]]\[([0-9]{1,3};)*[0-9]{1,3}m//g" 1>&4
}

function log_warning()
{
    local message="${@:-}"
    echo -e "${YELLOW_ON:-}Warning: ${message[@]}${COLOR_OFF:-}" 1>&3
    echo -e "Warning: ${message[@]}" | sed -r "s/[[:cntrl:]]\[([0-9]{1,3};)*[0-9]{1,3}m//g" 1>&4
}

function log_info()
{
    local message="${@:-}"
    echo -e "${GREEN_ON:-}Info: ${message[@]}${COLOR_OFF:-}" 1>&3
    echo -e "Info: ${message[@]}" | sed -r "s/[[:cntrl:]]\[([0-9]{1,3};)*[0-9]{1,3}m//g" 1>&4
}

function abort()
{
    local exit_code="${1:-1}"
    logit "${RED_ON:-}Aborting execution.${COLOR_OFF:-}"
    exit $(( ${exit_code} ))
}

function setup_logger_fds()
{
    exec 3>&2
    exec 4>/dev/null
}

function setup_logger_color_formatters()
{
    if [[ -t 2 ]] && [[ -z "${NO_COLOR:-}" ]] && [[ "${TERM:-}" != "dumb" ]]
    then
        COLOR_OFF="\033[0m"
        RED_ON="\033[0;31m"
        ORANGE_ON="\033[0;33m"
        YELLOW_ON="\033[1;33m"
        GREEN_ON="\033[0;32m"
        CYAN_ON="\033[0;36m"
        BLUE_ON="\033[0;34m"
        PURPLE_ON="\033[0;35m"
    else
        COLOR_OFF=""
        RED_ON=""
        ORANGE_ON=""
        YELLOW_ON=""
        GREEN_ON=""
        CYAN_ON=""
        BLUE_ON=""
        PURPLE_ON=""
    fi
}

function setup_logger()
{
    setup_logger_fds
    setup_logger_color_formatters
}

function init()
{
    setup_logger 
}

function show_manual_page()
{
    local manual_page_path="${TEMP_DIR_PATH}/manual-page.txt"

    echo "${MANUAL_PAGE_TEMPLATE}" 1>"${manual_page_path}"

    #
    # Remove leading spaces.
    #

    sed -ri "s/^\s{4}//" "${manual_page_path}"

    #
    # Fill in template fields.
    #

    sed -ri "s/@\{SCRIPT_NAME\}/${THIS_SCRIPT_NAME}/g" "${manual_page_path}"

    cat "${manual_page_path}" 1>&3
    cat "${manual_page_path}" 1>&4
}

function main()
{
    log_info "Adding GNOME terminal profiles..."

    for CONFIG_FILE_PATH in $(find "${THIS_SCRIPT_DIR_PATH}/gnome-terminal-profiles.d" | tail -n +2)
    do
        source "${CONFIG_FILE_PATH}"

        local GNOME_TERM_PROFILES_DCONF_PATH="/org/gnome/terminal/legacy/profiles:"
        local PROFILES="$(dconf read "${GNOME_TERM_PROFILES_DCONF_PATH}/list" | sed -r -e "s/\[//" -e "s/\]//")"

        if $(echo "${PROFILES}" | grep -Pq "${DCONF_UUID}")
        then
            log_info "Profile '${DCONF_NAME}' already installed."
            continue
        else
            log_info "Adding profile '${DCONF_NAME}'."
        fi

        if [ "${PROFILES}" == "" ]
        then
            PROFILES="['${DCONF_UUID}']"
        else
            PROFILES="[${PROFILES}, '${DCONF_UUID}']"
        fi

        dconf write "${GNOME_TERM_PROFILES_DCONF_PATH}/list" "${PROFILES}"
        dconf write "${GNOME_TERM_PROFILES_DCONF_PATH}/:${DCONF_UUID}/visible-name" "'${DCONF_NAME}'"
        dconf write "${GNOME_TERM_PROFILES_DCONF_PATH}/:${DCONF_UUID}/audible-bell" "${DCONF_AUDIBLE_BELL}"
        dconf write "${GNOME_TERM_PROFILES_DCONF_PATH}/:${DCONF_UUID}/palette" "${DCONF_PALETTE}"

        if [ "${IS_DEFAULT}" == "yes" ]
        then
            dconf write "${GNOME_TERM_PROFILES_DCONF_PATH}/default" "'${DCONF_UUID}'"
        fi
    done
}

init
parse_command_line "$@"
main
