#!/bin/zsh

DOTFILES_DIRECTORY="${HOME}/.dotfiles"
DOTFILES_TARBALL_PATH="https://github.com/nathanlong/dotfiles/tarball/main"
DOTFILES_GIT_REMOTE="git@github.com:nathanlong/dotfiles.git"

# If missing, download and extract the dotfiles repository
# Allows running the install command as a one liner ... but do we really need it?
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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  e_success "Homebrew installed"
fi

# Check for git
if ! type_exists 'git'; then
  e_header "Updating Homebrew..."
  brew update
  e_header "Installing Git..."
  brew install git
  e_success "Git installed"
fi

# Initialize the git repository if it's missing
if ! is_git_repo; then
  e_header "Initializing git repository..."
  git init
  git remote add origin ${DOTFILES_GIT_REMOTE}
  git fetch origin main
  # Reset the index and working tree to the fetched HEAD
  git reset --hard FETCH_HEAD
  # Remove any untracked files
  git clean -fd
fi

# NOTE: May no longer need this?
# Enable python support in neovim
#
# seek_confirmation "Enable python support in neovim?"
# if is_confirmed; then
# 	python3 -m pip install --user --upgrade pynvim
#     e_success "Added python provider to neovim."
# else
# 	printf "Skipping neovim python support.\n"
# fi

# Create a symlink
link() {
  ln -fs "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}

mirrorfiles() {
  # Create neovim directory
  mkdir ~/.config/nvim

  # Create the necessary symbolic links between the `.dotfiles` and `HOME` dirs.
  link "term/wezterm.lua"   ".wezterm.lua"
  link "zsh/zshrc"          ".zshrc"
  link "git/gitconfig"      ".gitconfig"
  link "git/gitignore"      ".gitignore"
  link "vim/init.vim"       ".config/nvim/init.vim"

  # Connect local neovim overrides
  e_header "Where do you keep your local nvim overrides? Enter the path or hit ENTER to skip."
  read -e -p "> " nvimpath
  if [[ $nvimpath ]]; then
      ln -fs `eval echo $nvimpath` "${HOME}/.config/nvim/local.vim"
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
seek_confirmation "Warning: This step may overwrite your existing dotfiles. Create symlinks for configs?"
if is_confirmed; then
    mirrorfiles
    source ${HOME}/.zshrc
else
    printf "Aborting...\n"
    exit 1
fi
