#
# Setup the 'PATH' variable.
#

declare -a path_list
path_list=()
path_list+=("/usr/local/bin")

for p in "${path_list[@]}"
do
    if ! $(echo "${PATH}" | grep -Pq "(^|:)${p}(:|$)")
    then
        export PATH="${path}:${PATH}"
    fi
done

#
# Setup other variables.
#

# n/a
