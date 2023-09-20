# Source system wide settings.
FILE="/etc/bashrc"
if [ -f "${FILE}" ]
then
    source "${FILE}"
fi

# Source user defined settings.
DIR="${HOME}/.bashrc.d"
if [ -d "${DIR}" ]
then
    while read FILE
    do
        source "${FILE}"
    done <<<"$( find "${DIR}" -name "*.bashrc" )"
fi

# References
# - https://opensource.com/article/19/7/bash-aliases

