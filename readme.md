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

# LSPs

There are three parts to how LSPs are installed and configured:

1. **Mason** — installs server *binaries* only in `~/.local/share/nvim/mason/bin`, which Mason prepends to `PATH` inside Neovim.
2. **nvim-lspconfig** — ships ~407 ready-made server *configs* as `lsp/<name>.lua` files. Lazy puts its directory on the `runtimepath`. The `lspconfig.util` helpers are a side-car, not the main payload.
3. **Neovim core** (`vim.lsp.config` / `vim.lsp.enable`) — merges configs and starts clients. See `:h lsp-config`.

Neovim collects **every** `lsp/<name>.lua` on the `runtimepath` and merges them with `tbl_deep_extend('force', ...)`. Later sources win:

1. `lsp/` on the runtimepath — nvim-lspconfig's copies live here
2. `after/lsp/` on the runtimepath — **any overrides live here**
3. `vim.lsp.config('<name>', {...})` calls — highest precedence
4. `vim.lsp.config('*', {...})` — special case, merges *lowest*, below everything above

To add an LSP server:

1. Install the binary: `:Mason`
2. Add its name to the `vim.lsp.enable({...})` list in `init.lua`
3. Only if defaults need changing, create `after/lsp/<name>.lua`
