# Nathan's Dotfiles

## 🛠  Basic toolkit:

- `neovim` (the goodness that is `vim` but with LSPs and MORE)
- `zsh` (`bash`, but like, newer, and because apple forced us to...)
    - p10k prompt (nice defaults, easy setup)
    - bashmarks (cd shortcuts, embedded for no outside dependencies)
- `wezterm`
- `homebrew` (bin package manager)
- `asdf` (for managing other languages)
    - node
    - ruby
    - yarn

## ⚡️ Neovim Features:

- LSP integration for intellisense-style code completion! 
- Treesitter for highlighting and smart selection expansion!
- Prettier for auto-formatting magic! 
- Powerful fuzzy-finder for files, search in project, and other patterns!
- Oh-so-fancy statusline, icons, and visual indicators!

## 💻 Installation:

### Option 1: Live Dangerously

Plop this in your terminal:

`zsh -c "$(curl -fsSL raw.github.com/nathanlong/dotfiles/main/bin/install.sh)"`

### Option 2: Do it Manually

- Install `brew` and `git`
- `git clone git@github.com:nathanlong/dotfiles.git ~/.dotfiles`
- Run the install script with `./bin/install.sh`...
- **OR** ...
  - Manually symlink the config files to the appropriate places
    - zsh: `~/.zshrc`
    - nvim: `~/.config/nvim`
    - git: `~/.git*` (both files)
    - wezterm: `~/.wezterm.lua`
