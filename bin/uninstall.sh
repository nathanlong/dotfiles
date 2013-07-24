#!/usr/bin/env bash

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

cd ${DOTFILES_DIRECTORY}

read -p "This will completely remove all dotfiles and references. Are you sure? (y/n) " -n 1
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo rm -r ${DOTFILES_DIRECTORY}
    rm ${HOME}/.bashrc
    rm ${HOME}/.bash_profile
    rm ${HOME}/.inputrc
    rm ${HOME}/.gitconfig
    rm ${HOME}/.gitignore
    rm ${HOME}/.vim
    rm ${HOME}/.gvimrc
    rm ${HOME}/.vimrc

    echo "Dotfiles removed."
fi

