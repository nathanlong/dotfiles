# Nate's Dotfiles

AKA Vimtastic Front-End Development settings.

## How to install

    bash -c "$(curl -fsSL raw.github.com/nathanlong/dotfiles/master/bin/install.sh)"

This grabs down the install script which fetches the source from Github, moves
it into `~/.dotfiles`, fetches Homebrew, Node, RVM, and their specified
packages, then reconnects the source to the repository and creates symlinks
into your local system.

## To Update

There are two processes to update everything:

    cd ~/.dotfiles
    git pull

That'll grab everything except the Vim plugins, which are managed by
[Vundle](https://github.com/gmarik/Vundle.vim). To update those, enter Vim and
run:

    :PluginUpdate

Boom. Everything will be up to date.

## Installation List

Homebrew formulae:

- Git
- Ack
- Node
- Par
- The Silver Searcher

Node packages (global):

- Gulp
- JSHint
- CSSLint

Ruby gems (managed through RVM):

- Compass
- Boom

Vim plugins:

- Ag
- Airline
- Change Inside Surroundings
- Commentary
- CtrlP
- delimitMate
- EasyMotion
- Emmet
- Gundo
- MatchTag
- Matchit
- Multiple Cursors
- Nerdtree
- Repeat
- Supertab
- Surround
- Syntastic
- Tabular
- Ultisnips
- Unimpaired
- VimWiki
- Wildfire

Vim syntax plugins:

- Better PHP indenting
- Haml syntax
- html5 syntax
- Javascript syntax
- jQuery syntax
- Less syntax
- Liquid syntax
- Markdown syntax (custom)
- Ruby syntax

Vim colorschemes:

- Solarized
- Tomorrow (custom)
- Writer (custom)

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
