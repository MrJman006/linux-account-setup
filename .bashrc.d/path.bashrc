# Adds paths to the user's 'PATH' environment variable.

function _load_path_env_var()
{
    local path_list=()

    path_list+=("/usr/local/bin")

    local path
    for path in "${path_list[@]}"
    do
        echo "${path}" | grep -Pq "(^|:)${path}(:|$)" || export PATH="${path}:${PATH}"
    done
}

_load_path_env_var
