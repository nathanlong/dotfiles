#!/usr/bin/env bash

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

cd ${DOTFILES_DIRECTORY}

source ./lib/utils

seek_confirmation "Warning: This will completely remove all dotfiles and references."

if is_confirmed; then
    sudo rm -r ${DOTFILES_DIRECTORY}
    rm ${HOME}/.bashrc
    rm ${HOME}/.bash_profile
    rm ${HOME}/.inputrc
    rm ${HOME}/.gitconfig
    rm ${HOME}/.gitignore
    rm ${HOME}/.vim
    rm ${HOME}/.gvimrc
    rm ${HOME}/.vimrc
else
    printf "Aborting...\n"
    exit 1
fi

seek_confirmation "Remove local overrides too?"

if is_confirmed; then
    rm ${HOME}/.bashrc.local
    rm ${HOME}/.gitconfig.local
    rm ${HOME}/.vimrc.local
else
    printf "Skipping...\n"
fi

e_success "Dotfiles removed."
