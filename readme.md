# Nate's Dotfiles

⚠️ I'm currently in the middle of refactoring my neovim setup. LSPs and
Treesitter, oh my!

## Basic toolkit:

- zsh
    - p10k prompt ()
    - bashmarks (cd shortcuts)
- neovim (the goodness that is vim but with LSPs and more)
- homebrew (bin package manager)
- asdf (for managing other languages)
    - node
    - ruby
    - yarn


## Installation

My one-line installer is old, so don't use that. For right now it's a process
of:

- Install the repo to `~/.dotfiles`
- Symlink the config files to the appropriate places
    - zsh: `~/.zshrc`
    - nvim: `~/.config/nvim`
    - git: `~/.git*` (both files)
- Install Homebrew and git
- Run install lists for:
    - brew
    - asdf
    - node/npm

I'm on the fence right now about packing these back up in an install script,
since I really only reinstall once every few years...
