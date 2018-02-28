#!/bin/bash

# Fail if an error happens
set -e

timestamp() {
    date +"%Y-%m-%d_%H-%M-%S"
}

print_usage() {
    echo "Usage: ${0} </path/to/dotfiles-repository>"
}

check_and_backup_file() {
    # Check for existence in HOME of $1 (first argument)
    if test -e ${1} ; then
        echo "File ${1} exists already."
        # create directory in HOME called backup (if not existent)
        mkdir -p "${HOME}/.dotfiles_backup"
        # Copy file into this directory with current timestamp appended
        new_filename=$(basename ${1})$(timestamp)
        echo "Backing up ${1} to ${HOME}/.dotfiles_backup/${new_filename}"
        cp ${1} ${HOME}/.dotfiles_backup/${new_filename}
    fi
}

ask_for_user_permission() {
    read -n 1 -p "Do you want that? Hit any key to continue or ctrl+c to stop execution: " bla
    echo
}

symlink() {
    # If there are double slashes, they are silently ignored
    if test ! -e ${1} ; then
        echo "Source File does not exist. Stopping execution."
        exit 1
    fi
    echo "About to symlink ${1} to ${2}"
    ask_for_user_permission
    check_and_backup_file ${2}
    # Symlink even if there are existing files as we have backuped them
    echo "Symlinking ${1} to ${2}"
    ln -sf ${from} ${to}
    echo
}



# Stop if not enough arguments
if test ${#} -ne 1 ; then 
    echo "Invalid number of arguments (${#}). Please provide the path to the dotfiles repository."
    print_usage
    exit 1
fi

# Stop if the argument arg is not a directory
if test ! -d ${1} ; then
    echo "${1} is not a directory."
    print_usage
    exit 1
fi

DOTFILES_DIR="${1}"

echo "Installing dotfiles on this System. Be aware that this might break stuff."
echo 

echo "##############"
# Symlink the actual dotfiles repository
from="${DOTFILES_DIR}"
to="${HOME}/.dotfiles"
symlink ${from} ${to}
echo "##############"

# Files to symlink and their corresponding directories relative to the dotfiles repo
FILES=(".bashrc" ".vimrc" ".tmux.conf" ".bash_profile" ".gitignore_global" ".gitconfig")
LOCATIONS=("" "" "" "" "git/" "git/")

# Now for every file to symlink, backup it if necessary and symlink it.
for index in ${!FILES[@]}; do
    from="${DOTFILES_DIR}/${LOCATIONS[${index}]}${FILES[${index}]}"
    to="${HOME}/${FILES[${index}]}"
    symlink ${from} ${to}
    echo "##############"
done

exit 0
