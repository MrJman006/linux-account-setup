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
    # Prompt for the user's name.
    #

    local commiter_email
    read -p "Commiter Email: " commiter_email
    git config user.name "${commiter_email}"

    #
    # Add a .gitignore file.
    #

    echo "# Ignore files starting with underscores." >> .gitignore
    echo "_*" >> .gitignore
    echo "" >> .gitignore

    echo "# Ignore files starting with periods." >> .gitignore
    echo ".*" >> .gitignore
    echo "" >> .gitignore

    echo "# Ignore specific directories." >> .gitignore
    echo "# n/a" >> .gitignore
    echo "" >> .gitignore

    echo "# Ignore specific files." >> .gitignore
    echo "# n/a" >> .gitignore
    echo "" >> .gitignore

    git add -f .gitignore

    #
    # Add a .gitattributes file.
    #

    echo "# Automate line ending handling for different operating systems." >> .gitattributes
    echo "text=auto" >> .gitattributes

    git add -f .gitattributes

    #
    # Make the first commit.
    #

    git commit -m "$(echo "Added repository configuration files.")"

    #
    # Rename the default branch to 'main'.
    #

    git branch | grep -Pq "main" || git branch -M main

    #
    # Notify the user.
    #

    echo "Git repo setup successfully."
}

export GIT_EDITOR=vim

alias gs="git status"
alias ga="git add"
alias gd="git diff --diff-algorithm=patience"
alias gl="git log"
alias glt="git log --graph --oneline --decorate --all"
alias gc="git commit"
alias gp="git push"
