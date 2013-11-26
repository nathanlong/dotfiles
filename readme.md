# Nate's Dotfiles

AKA Vimtastic Front-End Development settings

## How to install

Run this:

    git clone git://github.com/nathanlong/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./bin/install.sh

This will clone a copy, move into the new directory, and run the installation
script. If you want to install the brew formulas and osx defaults run:

    ./lib/brew
    ./lib/osx

These are optional and only necessary during initial setup. (I might possibly
integrate these into the install script sometime in the future.)

## How to update

Two steps:

    cd ~/.dotfiles
    git pull

Boom. That'll catch most of it, except for the vim plugins. Since they're
submodules, they'll default to a floating head. If you want to update them
from THEIR source directories you'll have to do two things:

    git submodule foreach git checkout master
    git submodule foreach git pull

This removes the floating head, attaches it to the master branch and pulls the
lastest from master. You can also run this as:

    git small
    git smp

(Aliased from the included .gitconfig).

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
