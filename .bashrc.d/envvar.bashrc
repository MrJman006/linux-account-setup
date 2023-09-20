#
# Setup the 'PATH' variable.
#

path="/usr/local/bin"
echo "${path}" | grep -Pq "(^|:)${path}(:|$)" || export PATH="${path}:${PATH}"

#
# Setup other variables.
#

# n/a
