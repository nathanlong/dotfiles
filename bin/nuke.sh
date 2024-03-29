#!/bin/zsh

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

cd ${DOTFILES_DIRECTORY}

source ./lib/utils        # Script functions
source ./bin/uninstall.sh # Runs the dotfile uninstall first

seek_confirmation "Warning: This will completely nuke Homebrew and Node. Still ok?"
if is_confirmed; then

  # Remove Homebrew and Node
  if type_exists 'brew'; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
  fi

  # Remove global node packages
  if [ -d "${HOME}/.npm" ]; then
    rm -rf ${HOME}/.npm
  fi

  e_success "Homebrew, Node, and dotfiles removed. Squeaky clean."
else
  printf "Aborting..."
  exit
fi


