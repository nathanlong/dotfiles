# Nathan's Dotfiles

## 🛠  Basic toolkit:

- `neovim` (the goodness that is `vim` but with LSPs and MORE)
    - Optimized for front-end development.
- `zsh` 
    - p10k prompt (nice defaults, easy setup)
    - bashmarks (cd shortcuts, embedded for no outside dependencies)
- `wezterm` (my favorite terminal editor)
- `homebrew` (bin package manager)
- `asdf` (for managing other languages)

## 💻 Installation:

### Terminal Emulator

Download [WezTerm](https://wezterm.org/).

### Download Homebrew and Git

Follow the [Homebrew installation instructions](https://brew.sh/) then install [Git](https://git-scm.com/) with:

```
brew install git
```

### Checkout dotfiles

Checkout a clone of these files with:

```
git clone git@github.com:nathanlong/dotfiles.git ~/.dotfiles
```

Then `cd ~/.dotfiles`

### Run the install script

All the config files are managed from the `~/.dotfiles` directory, but we create symlinks to all the different config locations. To run the full install:

```
cd ~/.dotfiles
./bin/install.sh
```
Follow the prompts to link the configs, and download brew and global npm packages.

### Open Neovim, install plugins

Now that Neovim is installed, run `nvim` in the terminal and [Lazy.nvim](https://lazy.folke.io/) should install all Neovim plugins.

And that should be it! Happy coding!

