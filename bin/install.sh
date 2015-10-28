#!/usr/bin/env bash

DOTFILES_DIRECTORY="${HOME}/.dotfiles"
DOTFILES_TARBALL_PATH="https://github.com/nathanlong/dotfiles/tarball/master"
DOTFILES_GIT_REMOTE="git@github.com:nathanlong/dotfiles.git"

# If missing, download and extract the dotfiles repository
if [[ ! -d ${DOTFILES_DIRECTORY} ]]; then
  printf "$(tput setaf 7)Downloading dotfiles...\033[m\n"
  mkdir ${DOTFILES_DIRECTORY}
  # Get the tarball
  curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOTFILES_TARBALL_PATH}
  # Extract to the dotfiles directory
  tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOTFILES_DIRECTORY}
  # Remove the tarball
  rm -rf ${HOME}/dotfiles.tar.gz
fi

cd ${DOTFILES_DIRECTORY}

source ./lib/utils # Script functions
source ./lib/brew  # Sources run_brew(), but doesn't run it yet
source ./lib/npm   # Sources run_npm(), but doesn't run it yet
source ./lib/rvm   # Sources run_rvm(), but doesn't run it yet

# Before relying on Homebrew, check that packages can be compiled
if ! type_exists 'gcc'; then
  e_error "The XCode Command Line Tools must be installed first."
  printf "  Download them from: https://developer.apple.com/downloads\n"
  printf "  Then run: bash ~/.dotfiles/bin/install.sh\n"
  exit 1
fi

# Check for Homebrew
if ! type_exists 'brew'; then
  e_header "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Check for git
if ! type_exists 'git'; then
  e_header "Updating Homebrew..."
  brew update
  e_header "Installing Git..."
  brew install git
fi

# Check for RVM, if not then install with latest stable ruby
if ! type_exists 'rvm'; then
  e_header "Installing RVM..."
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
fi

# Initialize the git repository if it's missing
if ! is_git_repo; then
  e_header "Initializing git repository..."
  git init
  git remote add origin ${DOTFILES_GIT_REMOTE}
  git fetch origin master
  # Reset the index and working tree to the fetched HEAD
  # (submodules are cloned in the subsequent sync step)
  git reset --hard FETCH_HEAD
  # Remove any untracked files
  git clean -fd
fi

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

    # Create untracked directories
    mkdir ~/.dotfiles/vim/tmp
    mkdir ~/.dotfiles/vim/bundle

    # Add vundle for vim plugins
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    e_success "Added Vundle to manage Vim plugins. Initializing plugins..."
    vim +PluginInstall +qall
    e_success "Plugins initialized."

    # Connect local vim overrides
    e_header "Where do you keep your local vim overrides? Enter the path or hit ENTER to skip."
    read -e -p "> " vimpath
    if [[ $vimpath ]]; then
        ln -fs `eval echo $vimpath` "${HOME}/.vimrc.local"
    fi

    # Connect local git overrides
    e_header "Where do you keep your local git overrides? Enter the path or hit ENTER to skip."
    read -e -p "> " gitpath
    if [[ $gitpath ]]; then
        ln -fs `eval echo $gitpath` "${HOME}/.gitconfig.local"
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

# Ask before potentially overwriting OS X defaults
seek_confirmation "Warning: This step may modify your OSX system defaults. Is this ok?"
if is_confirmed; then
  bash ./lib/osx
  e_success "OS X settings updated! You may need to restart."
else
  printf "Skipping OSX settings...\n"
fi

# Ask about packages
seek_confirmation "Warning: this will install packages for Homebrew, Node, and Ruby. Is this ok?"
if is_confirmed; then
  printf "Updating packages...\n"
  # Install Homebrew formulae
  run_brew
  # Install Node packages
  run_npm
  # Install Ruby gems
  run_rvm
  e_success "Packages installed"
else
  printf "Skipping packages... \n"
fi
