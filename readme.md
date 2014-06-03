# Nate's Dotfiles

AKA Vimtastic Front-End Development settings

**Dependencies**

- [Homebrew](http://brew.sh/) (to install Git)
- [Git](http://git-scm.com/) (for Vundle)

## How to install

Run this:

    git clone git@github.com:nathanlong/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./bin/install.sh

This will clone a copy, move into the new directory, and run the installation
script. If you want to install the brew formulas and osx defaults run:

    ./lib/brew
    ./lib/osx

These are optional and only necessary during initial setup. (I might possibly
integrate these into the install script sometime in the future.)

## To Update

There are two processes to update everything:

    cd ~/.dotfiles
    git pull

That'll grab everything except the Vim plugins, which are managed by
[Vundle](https://github.com/gmarik/Vundle.vim). To update those, enter Vim and
run:

    :PluginUpdate

Boom. Everything will be up to date.

## Local Overrides

For private settings, or environment specific settings use the following files,
all are sourced by default and you have the option to link them from the
install script if you have them ready.

- Bash = `~/.bashrc.local`
- Vim = `~/.vimrc.local`
- Git = `~/.gitconfig.local`

## Acknowledgements

These files are the result of my own elbow grease and the super smart settings
from other people, I tip my hat to:

- [Mathias Bynens's Dotfiles](https://github.com/mathiasbynens/dotfiles)
- [Necolas's Dotfiles](https://github.com/necolas/dotfiles)
- [Tim Pope's Dotfiles](https://github.com/tpope/tpope)
- [Holman's Dotfiles](https://github.com/holman/dotfiles/)
- and many others...
