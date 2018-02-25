# If not running interactively return from reading the rest.
test -z "$PS1" && return

# Define dotfiles path
DOTFILES_DIR="${HOME}/.dotfiles"

# Source all helper dotfiles here.
for file in "${DOTFILES_DIR}/."{'alias','env','functions','prompt'};
do
    echo "${file}"
    # source "${file}"
done
