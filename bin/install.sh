#!/usr/bin/env bash

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

cd ${DOTFILES_DIRECTORY}

source ./lib/utils

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
    e_header "Initializing git submodules..."
    git submodule --quiet init
    git submodule --quiet update
    e_success "Submodules initialized."

    # Connect local vim overrides
    e_header "Where do you keep your local vim overrides? Enter the path or hit ENTER to skip."
    read -e -p "> " vimpath
    eval $vimpath = $vimpath #expands variables and ~
    if [[ $vimpath ]]; then
        ln -fs "$vimpath" "${HOME}/.vimrc.local"
    fi

    # Connect local git overrides
    e_header "Where do you keep your local git overrides? Enter the path or hit ENTER to skip."
    read -e -p "> " gitpath
    eval $gitpath = $gitpath #expands variables and ~
    if [[ $gitpath ]]; then
        ln -fs "$gitpath" "${HOME}/.gitconfig.local"
    fi

    # Connect Ultisnip files
    e_header "Where do you keep your Ultisnip files (no trailing /)? Enter the path or hit ENTER to skip."
    read -e -p "> " ultipath
    eval $ultipath = $ultipath #expands variables and ~
    if [[ $ultipath ]]; then
        ln -fs "$ultipath" "${DOTFILES_DIRECTORY}/vim/UltiSnips"
    fi

    e_success "Dotfile installation complete."
}

# Ask before potentially overwriting files
seek_confirmation "Warning: This step may overwrite your existing dotfiles."

if is_confirmed; then
    mirrorfiles
    source ${HOME}/.bash_profile
else
    printf "Aborting...\n"
    exit 1
fi

