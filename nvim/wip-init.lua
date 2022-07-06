-- WORK IN PROGRESS (not actually used, yet)
--
-- I'm testing converting my config files to lua slowly. RIGHT NOW I'm ok with
-- a mix, but as lua becomes more prevalent, and my lua block in the config
-- files grows, it may become beneficial to switch over.
--
-- WE SHALL SEE...
--
-- Changes from mixed vimscript/lua setup:
-- vim-plug -> packer (for native lua syntax)
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- LUA/VIM BINDINGS
------------------------------------------------------------------------------

local fn = vim.fn
local keymap = vim.api.nvim_set_keymap
local augid = vim.api.nvim_create_augroup('user', { clear = true })
local autocmd = function(event, opts)
  return vim.api.nvim_create_autocmd(event, vim.tbl_extend('force', { group = augid }, opts))
end

------------------------------------------------------------------------------
-- PLUGINS
------------------------------------------------------------------------------

-- if packer isn't installed, lets grab it
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 
    'clone', 
    '--depth', '1', 
    'https://github.com/wbthomason/packer.nvim', 
    install_path
  })
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- General
  use 'briandoll/change-inside-surroundings.vim'
  use 'easymotion/vim-easymotion'
  use 'mattn/emmet-vim'
  use 'rking/ag.vim'
  use 'preservim/nerdtree'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'simnalamburt/vim-mundo'
  use 'Raimondi/delimitMate'
  use 'editorconfig/editorconfig-vim'
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use { 'Yggdroot/LeaderF', run = ':LeaderfInstallCExtension' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- Syntax
  use 'captbaritone/better-indent-support-for-php-with-html'
  use 'nathanlong/vim-markdown'
  use 'othree/html5.vim'
  use 'pangloss/vim-javascript'
  use 'leafgarland/typescript-vim'
  use 'MaxMEllon/vim-jsx-pretty'
  use 'jparise/vim-graphql'
  use 'nelsyeung/twig.vim'
  use 'elixir-editors/vim-elixir'
  use 'lepture/vim-jinja'
  use 'evanleck/vim-svelte'
  -- Formatting
  use {
    'prettier/vim-prettier', 
    run = 'yarn install --frozen-lockfile --production',
    ft = {'javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'}
  }
  -- Interface
  use 'folke/which-key.nvim'
  use 'nathanlong/oceanic-next'
  use 'kyazdani42/nvim-web-devicons'
  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Wilder
  use {
    'gelguy/wilder.nvim',
    config = function()
      -- config goes here
      -- currently not well documented what can exist here
    end,
  }
  -- LSP integration and autocomplete
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  -- if we bootstrapped packer then sync config
  if packer_bootstrap then
    require('packer').sync()
  end
end)

------------------------------------------------------------------------------
-- SETTINGS
------------------------------------------------------------------------------

vim.opt.hidden = true -- Switch between buffers without saving
vim.opt.gdefault = true -- Apply substitutions globally on a line by default
vim.opt.timeoutlen = 200 -- Lowers leader+command timeout.
vim.opt.nobackup = true -- Get rid of backups
vim.opt.nowb = true -- Get rid of backups on write
vim.opt.noswapfile = true -- Get rid of swp files
vim.opt.clipboard = 'unnamedplus' -- Allow access to system clipboard
vim.opt.foldmethod = 'marker'
vim.opt.mouse = 'a' -- in most cases the mouse works just fine

-- Temp files, backups, and undos
vim.opt.directory = vim.fn.stdpath 'cache' .. '/tmp'  --Set temp directory
vim.opt.nobackup = true --Get rid of backups, I don't use them
vim.opt.nowb = true --Get rid of backups on write
vim.opt.noswapfile = true --Get rid of swp files, I have never used them

-- Persistent undo.
vim.opt.undofile = true
vim.g.undodir = vim.fn.stdpath 'cache' .. '/undo'
vim.opt.undolevels = 500
vim.opt.undoreload = 500

-- More useful command-line completion
vim.opt.wildmode = 'list:longest'
vim.opt.wildmenu = true

-- Interface
vim.opt.title = true -- Update the title
vim.opt.autoread = true -- Refresh files when changed outside of vim
vim.opt.number = true -- Line numbers
vim.opt.more = true -- Adds more prompt for long screen prints
vim.opt.ruler = true -- Cursor position in lower right
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case insensitive search
vim.opt.splitbelow = true -- split below the current window
vim.opt.splitright = true -- split vertical windows to the right
vim.opt.scrolloff = 4 -- always keeps cursor X lines from bottom
vim.opt.eadirection = "hor" -- only equalize horz when splitting or closing
vim.opt.sidescrolloff = 8 -- keep 7 chars onscreen when nowrap is set
vim.opt.winminheight = 0 -- Allow splits to be squashed to one line
vim.opt.winminwidth = 0
vim.opt.matchpairs:append = { "<:>" }

-- Set invisible/whitespace markers
vim.opt.listchars = { tab = "›", eol = "¬", trail = "⋅"}

-- Tab and Text
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.noexpandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.textwidth = 78
vim.opt.colorcolumn = +1 
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.formatoptions = qrn1

-- Colors
vim.opt.termguicolors = true -- Enable true color
vim.g.bg = "dark"
vim.g.colorscheme = "OceanicNext"

------------------------------------------------------------------------------
-- MAPPINGS
------------------------------------------------------------------------------

local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Map : to ; (then remap ;) -- massive pinky-saver
keymap("n", ";", ":", opts)
keymap("n", "<M-;>", ";", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<leader>b", "<C-^>", opts) -- last edited buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Indentation like other text editors
keymap("n", "<leader>[", "<<", opts)
keymap("n", "<leader>]", ">>", opts)
keymap("x", "<leader>[", "<gv", opts)
keymap("x", "<leader>]", ">gv", opts)

-- Tab selection
keymap("n", "<leader>1", "1gt", opts)
keymap("n", "<leader>2", "2gt", opts)
keymap("n", "<leader>3", "3gt", opts)
keymap("n", "<leader>4", "4gt", opts)
keymap("n", "<leader>5", "5gt", opts)
keymap("n", "<leader>6", "6gt", opts)
keymap("n", "<leader>7", "7gt", opts)
keymap("n", "<leader>8", "8gt", opts)
keymap("n", "<leader>9", "9gt", opts)

-- emac style jump to end of line in insert mode
-- checks for autocomplete menu
keymap("i", "<C-e>", function()
  return vim.fn.pumvisible() == 1 and "\<C-e>" or "/<C-o>A"
end, opts)
keymap("i", "<C-a>", "<C-o>I", opts)

-- Better escape from insert mode
keymap("i", "jk", "<Esc>", opts)

-- Bubble lines, move text up and down
-- Make sure iTerm has the option ket set to 'Esc+' for Alt bindings
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Duplicate lines above and below
keymap("n", "<S-A-j>", "Ypk", opts)
keymap("i", "<S-A-j>", "<esc>Ypk", opts)
keymap("x", "<S-A-j>", "y`>pgv", opts)
keymap("n", "<S-A-k>", "YPj", opts)
keymap("i", "<S-A-k>", "<esc>YPj", opts)
keymap("x", "<S-A-k>", "y`<Pgv", opts)

-- Remove search highlighting
keymap("n", "<leader><cr>", ":noh<cr>", opts)

-- Toggle invisibles
keymap("n", "<leader>L", ":set list!<CR>", opts)
 
-- Will open files in current directory, allows you to leave the working cd in
-- the project root. You can also use %% anywhere in the command line.
keymap("c", "%%", "<C-R>=expand('%:h').'/'<cr>", opts)
keymap("n", "<leader>ew", ":e %%", opts)
keymap("n", "<leader>es", ":sp %%", opts)
keymap("n", "<leader>ev", ":vsp %%", opts)
keymap("n", "<leader>et", ":tabe %%", opts)

-- Select a line without trailing whitespace or linebreaks
keymap("n", "<leader>l", "<esc>^vg_", opts)

------------------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------------------



------------------------------------------------------------------------------
-- AUTOCOMMANDS
------------------------------------------------------------------------------

autocmd({'BufRead,BufNewFile'}, {
  pattern = {"*.txt","*.text"}
  callback = function()
    local vim.g.filetype = "markdown"
  end
})

autocmd('Filetype', {
  pattern = {"css", "scss", "vim", "lua"},
  command = [[setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-]]
})

autocmd('Filetype', {
  pattern = {"markdown"},
  command = [[setlocal ts=2 sts=2 sw=2 expandtab spell]]
})

------------------------------------------------------------------------------
-- PLUGINS
------------------------------------------------------------------------------

-- Quick mappings
keymap("n", "<F1>", ":NERDTreeToggle<cr>", opts)
keymap("n", "<F2>", ":MundoToggle<CR>", opts)

if vim.fn.executable('ag') == 1 then
  vim.g.grpprg = "ag\ --nogroup\ --nocolor"
end
