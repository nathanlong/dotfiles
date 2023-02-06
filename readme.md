# Nathan's Dotfiles

## 🛠  Basic toolkit:

- `neovim` (the goodness that is `vim` but with LSPs and MORE)
- `zsh` (`bash`, but like, newer, and because apple forced us to...)
    - p10k prompt (nice defaults, easy setup)
    - bashmarks (cd shortcuts, embedded for no outside dependencies)
- `homebrew` (bin package manager)
- `asdf` (for managing other languages)
    - node
    - ruby
    - yarn
- `wezterm` (on a trial basis)

## ⚡️ Neovim Features:

- LSP integration for intellisense-style code completion! 
- Treesitter for highlighting and smart selection expansion!
- Prettier for auto-formatting magic! 
- Powerful fuzzy-finder for files, search in project, and other patterns!
- Oh-so-fancy statusline, icons, and visual indicators!

## 💻 Installation:

My one-line installer is old, so don't use that. For right now it's a process
of:

- Install the repo to `~/.dotfiles`
- Symlink the config files to the appropriate places
    - zsh: `~/.zshrc`
    - nvim: `~/.config/nvim`
    - git: `~/.git*` (both files)
    - wezterm: `~/.wezterm.lua`
- Install Homebrew and git
- Run install lists for:
    - brew
    - asdf
    - node/npm

I'm on the fence right now about packing these back up in an install script,
since I really only fully reinstall once every few years...
