#!/usr/bin/env bash

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

cd ${DOTFILES_DIRECTORY}

link() {
    # Force create/replace the symlink.
    ln -fs "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}

mirrorfiles() {
    # Force remove the vim directory if it's already there.
    if [ -e "${HOME}/.vim" ]; then
        rm -rf "${HOME}/.vim"
    fi

    # Create the necessary symbolic links between the `.dotfiles` and `HOME`
    # directory. The `bash_profile` sources other files directly from the
    # `.dotfiles` repository.
    link "bash/bashrc"        ".bashrc"
    link "bash/bash_profile"  ".bash_profile"
    link "bash/inputrc"       ".inputrc"
    link "git/gitconfig"      ".gitconfig"
    link "git/gitignore"      ".gitignore"
    link "vim"                ".vim"
    link "vim/gvimrc"         ".gvimrc"
    link "vim/vimrc"          ".vimrc"

    # Create vim junk drawer
    mkdir ~/.dotfiles/vim/tmp

    # Initialize git submodules
    git submodule init
    git submodule update

    echo "Dotfiles update complete!"
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	mirrorfiles
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		mirrorfiles
	fi
fi

