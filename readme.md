# Nathan's Dotfiles

## 🛠  Basic toolkit:

- neovim (the goodness that is vim but with LSPs and more)
- zsh
    - p10k prompt (nice defaults, easy setup)
    - bashmarks (cd shortcuts, embedded for no outside dependencies)
- homebrew (bin package manager)
- asdf (for managing other languages)
    - node
    - ruby
    - yarn

## ⚡️ Neovim Features

- LSP integration for intellisense-style code completion
- Prettier for auto-formatting magic
- Treesitter for highlighting and smart selection expansion
- Vim command-line completion
- Powerful fuzzy-finder for files, search patterns, and todos through
  Telescope (and other plugins, like ripgrep, etc.)
- Fancy statusline, icons, and visual indicators

## 💻 Installation

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
