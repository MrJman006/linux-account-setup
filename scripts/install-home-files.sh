#! /usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail
set -o nounset

readonly INVOKED_DATE_TIME="$(date +D%Y-%m-%d_T%H-%M-%S)"
readonly THIS_SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly THIS_SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
readonly PROJECT_DIR_PATH="$(cd "${THIS_SCRIPT_DIR_PATH}" && pwd -P)"
readonly CURRENT_USER="${SUPER_USER:-${USER:-$(whoami)}}"
readonly BACKUP_DIR_PATH="${HOME}/_home-files/${INVOKED_DATE_TIME}"

for HOME_FILE_RPATH in $(cd "${PROJECT_DIR_PATH}/home" | git ls-files)
do
    echo "Installing '${HOME_FILE_RPATH}'."

    HOME_FILE_DIR_RPATH="$(dirname "${HOME_FILE_RPATH}")"

    #
    # Backup existing home files.
    #

    mkdir -p "${BACKUP_DIR_PATH}/${HOME_FILE_DIR_RPATH}"
    mv "${HOME}/${HOME_FILE_RPATH}" "${BACKUP_DIR_PATH}/${HOME_FILE_RPATH}"

    #
    # Install the new home files.
    #

    mkdir -p "${HOME}/${HOME_FILE_DIR_RPATH}"
    cp -r "${PROJECT_DIR_PATH}/${HOME_FILE_RPATH}" "${HOME}/${HOME_FILE_RPATH}"
done
