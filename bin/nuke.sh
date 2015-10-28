#!/usr/bin/env bash

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

cd ${DOTFILES_DIRECTORY}

source ./lib/utils        # Script functions
source ./bin/uninstall.sh # Runs the dotfile uninstall first

seek_confirmation "Warning: This will completely nuke Homebrew, Node, and RVM."
if is_confirmed; then

  # Remove Homebrew and Node
  if type_exists 'brew'; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
  fi

  # Remove global node packages
  if [ -d "${HOME}/.npm" ]; then
    rm -rf ${HOME}/.npm
  fi

  # Remove RVM
  if type_exists "rvm"; then
    rvm implode
  fi

  e_success "Homebrew, Node, and RVM removed. Squeaky clean."
else
  printf "Aborting..."
  exit
fi


