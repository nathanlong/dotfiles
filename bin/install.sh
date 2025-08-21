#!/bin/zsh

source ./lib/utils

DOTFILES="${HOME}/.dotfiles"

# Create symlinks
link() {
  ln -fs "${DOTFILES}/${1}" "${HOME}/${2}"
}

mirrorFiles() {
  # Create neovim directory
  mkdir ~/.config/nvim

  # Create the necessary symbolic links between the `.dotfiles` and `HOME` dirs.
  link "term/wezterm.lua"   ".wezterm.lua"
  link "zsh/zshrc"          ".zshrc"
  link "git/gitconfig"      ".gitconfig"
  link "git/gitignore"      ".gitignore"
  link "nvim"               ".config/nvim"
}

privateSettings() {
  # Check private git settings
  e_header "Checking private git settings..."
  if [[ -f "${HOME}/.gitconfig.private" ]]; then
    e_success "Private git settings found."
  else
    e_header "No private git settings found, copying over an empty config..."
    cp "${DOTFILES}/git/gitconfig.private.example" "${DOTFILES}/git/.gitconfig.private"
    link "git/gitconfig.private" ".gitconfig.private"
    e_success "Copied! Remember to edit ~/dotfiles/git/gitconfig.private with your information."
  fi

  # Check private nvim settings
  e_header "Checking private nvim settings..."
  if [[ -f "${DOTFILES}/nvim/lua/user/private.lua" ]]; then
    e_success "Private nvim settings found."
  else
    e_header "No nvim private nvim settings found, copying over an empty config..."
    cp "${DOTFILES}/nvim/lua/user/private.example.lua" "${DOTFILES}/nvim/lua/user/private.lua"
    e_success "Copied! Remember to edit ~/dotfiles/nvim/lua/user/private.lua with your information."
  fi
}

seek_confirmation "Install and link dotfiles?"
if is_confirmed; then
  mirrorFiles
  privateSettings
  source ${HOME}/.zshrc
  e_success "Configs linked!"
else
  printf "Aborting...\n"
  exit 1
fi

seek_confirmation "Install brew packages?"
if is_confirmed; then
  source ${DOTFILES}/lib/brew
  e_success "Brew packages installed"
else
  printf "Aborting...\n"
  exit 1
fi

seek_confirmation "Install global npm packages?"
if is_confirmed; then
  source ${DOTFILES}/lib/npm
  e_success "Global npm packages installed"
else
  printf "Aborting...\n"
  exit 1
fi
