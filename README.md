# My dotfile Repository
As with other dotfile repos this one is sort of the perfect combination of the strengths of many dotfile repos I've seen. Take a look and copy whatever you like.

## Installation
Usually this is done running
```
bash install.sh <path/to/dotfile/repository>
```
This will check whether the targets are already existing and will back them up to `~/.dotfiles_backup`.

Anyway, if you want to do it manually you can perform the following steps.
1. Clone this repository to `${HOME}/.dotfiles`. If this is not to your liking symlink via `${HOME}/.dotfiles` to the repository.
1. Create symlinks to the files `.bashrc`, `.vimrc`, `tmux.conf`, `.bash_profile`, `.gitconfig`, and `.gitignore_global`