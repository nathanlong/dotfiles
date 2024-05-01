#!/bin/zsh

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

cd ${DOTFILES_DIRECTORY}

source ./lib/utils

seek_confirmation "Warning: This will completely remove all dotfiles and references."
if is_confirmed; then
  sudo rm -r ${DOTFILES_DIRECTORY}
  rm -r ${HOME}/.config/nvim
  rm -r ${HOME}/.config/nvim
  rm -r ${HOME}/.local/shared/nvim
  rm ${HOME}/.bashrc
  rm ${HOME}/.bash_profile
  rm ${HOME}/.inputrc
  rm ${HOME}/.gitconfig
  rm ${HOME}/.gitignore
  e_success "Dotfiles removed."
else
  printf "Aborting...\n"
  exit 1
fi

seek_confirmation "Remove local overrides too?"

if is_confirmed; then
  rm ${HOME}/.bashrc.local
  rm ${HOME}/.gitconfig.local
  rm ${HOME}/.vimrc.local
  e_success "Local overrides removed."
else
  printf "Skipping...\n"
fi
