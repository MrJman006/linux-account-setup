export GIT_EDITOR=vim

function __setup_git_shortcuts()
{
    #
    # Define the shortcuts.
    #

    local shortcut_defs=()

    # Shortcut to set the 'user.name' config item.
    shortcut_defs+=('gcun=(git config user.name)')

    # Shortcut to set the 'user.email' config item.
    shortcut_defs+=('gcun=(git config user.name)')

    # Shortcut for working with branches.
    shortcut_defs+=('gb=(git branch)')

    # Shortcut for checking repo status.
    shortcut_defs+=('gs=(git status)')

    # Shortcut for adding files to the stage.
    shortcut_defs+=('ga=(git add)')

    # Shortcut for commiting staged files.
    shortcut_defs+=('gc=(git commit)')

    # Shortcut to diff files or commits.
    shortcut_defs+=('gd=(git diff --diff-algorithm=patience)')

    # Shortcut to diff staged files.
    shortcut_defs+=('gd=(git diff --diff-algorithm=patience --staged)')

    # Shortcut to show log entries on a particular branch.
    shortcut_defs+=('gl=(git log)')

    # Shortcut to show log entries on a particular branch for a specific set of files.
    shortcut_defs+=('glf=(git log --follow)')

    # Shortcut to show log entries on a particular branch in a graph format.
    shortcut_defs+=('glg=(git log --graph --oneline --decorate)')

    # Shortcut to show log entries on a particular branch for a specific set of files in a graph format.
    shortcut_defs+=('glgf=(git log --graph --oneline --decorate --follow)')

    # Shortcut to show log entries on all branches in a graph format.
    shortcut_defs+=('glga=(git log --graph --oneline --decorate --all)')

    # Shortcut to show log entries on all branches for a specific set of files in a graph format.
    shortcut_defs+=('glgaf=(git log --graph --oneline --decorate --all --follow)')

    # Shortcut to show log entries on a particular branch in a graph format with a little more detail.
    shortcut_defs+=('glgd=(git log --graph --date=short --pretty=format"%C(auto)%h %D%C(reset)%n%C(auto)subject: %s%C(reset)%n    %C(dim white)date: %ad%C(reset)%n%C(dim white)    author: %an%C(reset)%n")')

    # Shortcut to show log entries on a particular branch for a specific set of files in a graph format with a little more detail.
    shortcut_defs+=('glgdf=(git log --graph --date=short --pretty=format"%C(auto)%h %D%C(reset)%n%C(auto)subject: %s%C(reset)%n    %C(dim white)date: %ad%C(reset)%n%C(dim white)    author: %an%C(reset)%n" --follow)')

    # Shortcut to show log entries on all branches in a graph format with a little more detail.
    shortcut_defs+=('glgda=(git log --graph --date=short --pretty=format"%C(auto)%h %D%C(reset)%n%C(auto)subject: %s%C(reset)%n    %C(dim white)date: %ad%C(reset)%n%C(dim white)    author: %an%C(reset)%n" --all)')

    # Shortcut to show log entries on all branches for a specific set of files in a graph format.
    shortcut_defs+=('glgdaf=(git log --graph --date=short --pretty=format"%C(auto)%h %D%C(reset)%n%C(auto)subject: %s%C(reset)%n    %C(dim white)date: %ad%C(reset)%n%C(dim white)    author: %an%C(reset)%n" --all --follow)')

    #
    # Build the shortcuts with completions.
    #

    for shortcut_def in "${shortcut_defs[@]}"
    do
        local shortcut_name="$(echo "${shortcut_def}" | cut -d "=" -f 1)"
        local shortcut_command="$(echo "${shortcut_def}" | cut -d "=" -f 2 | sed -E "s/^\(|\)$//g")"
        local shortcut_func="function ${shortcut_name}(){ ${shortcut_command} \"\$@\"; }"
        local git_command="$(echo "${shortcut_command}" | tr -s " " | cut -d " " -f 2)"
        local completion_func_name="__completion_git_${git_command//-/_}"
        local completion_func="function ${completion_func_name}(){ __git_func_wrap _git_${git_command//-/_}; }"

        eval "${shortcut_func}"
        eval "${completion_func}"
        eval "complete -o bashdefault -o default -o nospace -F ${completion_func_name} ${shortcut_name}"
    done
}
__setup_git_shortcuts
unset __setup_git_shortcuts


function git_init()
{
    if [[ -d .git ]]
    then
        echo "The current directory appears to already be a git repo. Remove '.git' and run this command again if you want to set this directory up as a brand new git repository."
        return 1
    fi

    #
    # Create the repo.
    #

    git init || return 1

    #
    # Prompt for the user's name.
    #

    local commiter_name
    read -p "Commiter Name: " commiter_name
    git config user.name "${commiter_name}"

    #
    # Prompt for the user's email.
    #

    local commiter_email
    read -p "Commiter Email: " commiter_email
    git config user.email "${commiter_email}" 

    #
    # Add a .gitignore file.
    #

    echo "# Ignore files starting with underscores." >> .gitignore
    echo "_*" >> .gitignore
    echo "" >> .gitignore

    git add .gitignore

    #
    # Add a .gitattributes file.
    #
 
    echo "#" >> .gitattributes
    echo "# Automate line ending handling for different operating systems." >> .gitattributes
    echo "#" >> .gitattributes
    echo "" >> .gitattributes
    echo "text=auto, eol=lf" >> .gitattributes

    git add .gitattributes

    #
    # Make the first commit.
    #

    git commit -m "$(echo "Added repository configuration files.")"

    #
    # Rename the default branch to 'main'.
    #

    if ! $(git branch | grep -Pq "main")
    then
        git branch -M main
    fi

    #
    # Notify the user.
    #

    echo "Git repo setup successfully."
}
