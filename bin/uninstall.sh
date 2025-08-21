#!/bin/zsh

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

source ./lib/utils

seek_confirmation "Uninstall dotfiles?"
if is_confirmed; then
  sudo rm -r ${DOTFILES_DIRECTORY}
  rm -r ${HOME}/.config/nvim
  rm -r ${HOME}/.local/shared/nvim
  rm ${HOME}/.zshrc
  rm ${HOME}/.bash_profile
  rm ${HOME}/.gitconfig
  rm ${HOME}/.gitignore
  e_success "Dotfiles removed."
else
  printf "Aborting...\n"
  exit 1
fi

seek_confirmation "Remove local overrides too?"

if is_confirmed; then
  rm ${HOME}/.zshrc.local
  rm ${HOME}/.gitconfig.private
  e_success "Local overrides removed."
else
  printf "Skipping...\n"
fi
