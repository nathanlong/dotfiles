------------------------------------------------------------------------------
-- Nathan's NeoVim Config   
-- Goals: 
-- * Single file (I tinker often, and I don't like hunting partials)
-- * Easy to reference (I forget my own mappings often)
-- * Prefer defaults when possible (minimal crazy config setup)
-- * Vetted tooling (The lastest and greatest plugins and features)
--
-- Sections:
-- * Lua/Vim bindings
-- * Plugin manager
-- * Settings
-- * Mappings
-- * Helper functions
-- * Autocommands
-- * Plugin Setup and Settings
-- * Machine Specific Settings
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- LUA/VIM BINDINGS
-- Set aliases for the longer api calls
------------------------------------------------------------------------------

local fn = vim.fn
local o = vim.opt
local g = vim.g
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local optsnos = { noremap = true }
local augid = vim.api.nvim_create_augroup('user', { clear = true })
local autocmd = function(event, opts)
  return vim.api.nvim_create_autocmd(event, vim.tbl_extend('force', { group = augid }, opts))
end

------------------------------------------------------------------------------
-- PLUGINS (plugin settings at bottom)
------------------------------------------------------------------------------

-- if packer isn't installed, lets grab it
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup({function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- General
  use 'briandoll/change-inside-surroundings.vim'
  use 'phaazon/hop.nvim'
  use 'mattn/emmet-vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'simnalamburt/vim-mundo'
  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'
  use 'gelguy/wilder.nvim'
  use 'editorconfig/editorconfig-vim'
  -- LSP integration and autocomplete
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  -- Telescope - fuzzy list finder (files, grep, todos)
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- Treesitter - syntax and context awareness
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- Extra syntax and language specific plugins
  use 'nathanlong/vim-markdown'
  use 'MaxMEllon/vim-jsx-pretty'
  use 'sukima/vim-tiddlywiki'
  use 'vim-ruby/vim-ruby'
  use 'tpope/vim-rails'
  -- Formatting
  use {
    'prettier/vim-prettier', 
    run = 'yarn install --frozen-lockfile --production',
    ft = {'javascript', 'typescript', 'css', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'}
  }
  -- Interface
  use 'lewis6991/gitsigns.nvim'
  use 'folke/todo-comments.nvim'
  use 'folke/which-key.nvim'
  use 'folke/tokyonight.nvim'
  use 'junegunn/goyo.vim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  -- if we bootstrapped packer then sync config
  if packer_bootstrap then
    require('packer').sync()
  end
end})

------------------------------------------------------------------------------
-- SETTINGS
------------------------------------------------------------------------------


o.hidden = true -- Switch between buffers without saving
o.timeoutlen = 250 -- Lowers leader+command timeout.
o.clipboard = 'unnamedplus' -- Allow access to system clipboard
o.foldmethod = 'marker'
o.mouse = 'a' -- in most cases the mouse works just fine

-- Temp files, backups, and undos
o.directory = vim.fn.stdpath 'cache' .. '/tmp'  --Set temp directory
g.nobackup = true --Get rid of backups, I don't use them
g.nowb = true --Get rid of backups on write
o.swapfile = false --Get rid of swp files, I have never used them

-- Persistent undo.
o.undofile = true
g.undodir = vim.fn.stdpath 'cache' .. '/undo'
o.undolevels = 500
o.undoreload = 500

-- More useful command-line completion
o.wildmode = 'list:longest'
o.wildmenu = true

-- Interface
o.title = true -- Update the title
o.autoread = true -- Refresh files when changed outside of vim
o.number = true -- Line numbers
o.more = true -- Adds more prompt for long screen prints
o.ruler = true -- Cursor position in lower right
o.ignorecase = true -- case insensitive search
o.smartcase = true -- case insensitive search
o.splitbelow = true -- split below the current window
o.splitright = true -- split vertical windows to the right
o.scrolloff = 4 -- always keeps cursor X lines from bottom
o.eadirection = "hor" -- only equalize horz when splitting or closing
o.sidescrolloff = 8 -- keep X chars onscreen when nowrap is set
o.winminheight = 0 -- Allow splits to be squashed to one line
o.winminwidth = 0

-- Set invisible/whitespace markers
o.listchars = { tab = '› ', eol = '¬', trail = '⋅' }

-- Tab and Text
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.shiftround = true
o.expandtab = false
o.smartindent = true
o.autoindent = true
o.textwidth = 80
o.colorcolumn = "+1" 
o.wrap = true
o.linebreak = true
o.formatoptions = "qrn1"

-- Colors
o.termguicolors = true -- Enable true color
g.bg = "dark"
vim.cmd[[colorscheme tokyonight]] -- is there not a better way to set this..?

------------------------------------------------------------------------------
-- MAPPINGS
------------------------------------------------------------------------------

-- Remove default neovim map for line yank (too much muscle memory)
vim.api.nvim_del_keymap("n", "Y")

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

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
keymap("n", "<leader>b", "<C-^>", opts) -- last edited buffer (super useful!)
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
keymap('i', '<C-e>', 'pumvisible() ? "\\<C-e>" : "\\<C-o>A"', {expr = true})
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
keymap("n", "<leader>I", ":set list!<CR>", opts)
 
-- Will open files in current directory, allows you to leave the working cd in
-- the project root. You can also use %% anywhere in the command line.
keymap("c", "%%", "<C-R>=expand('%:h').'/'<cr>", optsnos)
-- We need these to be recursive, so don't use noremap
keymap("n", "<leader>ew", ":e %%", {})
keymap("n", "<leader>es", ":sp %%", {})
keymap("n", "<leader>ev", ":vsp %%", {})
keymap("n", "<leader>et", ":tabe %%", {})

-- Select a line without trailing whitespace or linebreaks
-- keymap("n", "<leader>l", "<esc>^vg_", opts)

-- Quickly edit and source $MYVIMRC
keymap("n", "<leader>vv", ":tabnew $MYVIMRC<cr>", opts)
keymap("n", "<leader>vl", ":tabnew $HOME/.config/localconfig/local.vim<cr>", opts)
keymap("n", "<leader>vs", ":source $MYVIMRC<cr>", opts)

------------------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------------------

-- rg as grep
if fn.executable("rg") > 0 then
  vim.o.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
  vim.opt.grepformat = { "%f:%l:%c:%m" }
end

------------------------------------------------------------------------------
-- AUTOCOMMANDS
------------------------------------------------------------------------------

autocmd("BufRead,BufNewFile", {
  pattern = {"*.txt","*.text"},
  command = [[set filetype=markdown]]
})

autocmd("BufRead,BufNewFile", {
  pattern = {"*.njk"},
  command = [[set filetype=html]]
})

autocmd('Filetype', {
  pattern = {"css", "scss", "vim", "lua"},
  command = [[setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-]]
})

autocmd('Filetype', {
  pattern = {"markdown"},
  command = [[setlocal ts=2 sts=2 sw=2 expandtab spell]]
})

--------------------------------------------------------------------------------
-- PLUGIN SETTINGS
--------------------------------------------------------------------------------

-- Quick mappings
keymap("n", "<F1>", ":NvimTreeToggle<cr>", opts)
keymap("n", "<F2>", ":MundoToggle<CR>", opts)

-- LSP + AUTOCOMPLETE ----------------------------------------------------------
-- LSP Mappings + Settings (pulled from default setup)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings to magical LSP functions!
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Capabilities required for the visualstudio lsps?
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Activate LSPs
-- All LSPs in this list need to be manually installed
local lspconfig = require('lspconfig')
local servers = { 'tailwindcss', 'tsserver', 'html', 'cssls', 'jsonls', 'eslint', 'stylelint_lsp', 'svelte', 'solargraph' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilites = capabilities,
  }
end

-- CMP - Autocompletion
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
       -- vim.fn["UltiSnips#Anon"](args.body)
       require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' }
  },
}

-- Telescope -------------------------------------------------------------------
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
keymap("n", "<leader>fm", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", opts)
keymap("n", "<leader>ft", ":TodoTelescope<cr>", opts)

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')


-- Treesitter ------------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "html", "css", "php", "scss", "typescript", "vim", "lua" },
  highlight = { 
    enable = true,
    -- for things that may need additional synax help occasionally
    additional_vim_regex_highlighting = {"lua"},
  },
  incremental_selection = {
    enable = true,
    -- super easy incremental selection, keep pressing <CR> to grow
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
}

-- Wilder ----------------------------------------------------------------------
local wilder = require('wilder')
wilder.setup({ modes = {':', '/', '?'} })
-- allow fuzzy searching
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      language = 'python',
      fuzzy = 1,
    }),
    wilder.python_search_pipeline({
      pattern = wilder.python_fuzzy_pattern(),
      sorter = wilder.python_difflib_sorter(),
      engine = 're',
    })
  ),
})
-- enable popup with dev icons
wilder.set_option('renderer', wilder.popupmenu_renderer({
  highlighter = wilder.basic_highlighter(),
  left = {' ', wilder.popupmenu_devicons()},
  right = {' ', wilder.popupmenu_scrollbar()},
}))


-- Other Plugin Settings (sort by alpha) ---------------------------------------

-- Autopairs
require("nvim-autopairs").setup {}

-- Change Inside
keymap("n", "<leader>c", ":ChangeInsideSurrounding<CR>", opts)
keymap("n", "<leader>C", ":ChangeAroundSurrounding<CR>", opts)

-- Comments
require('Comment').setup {}

-- editorconfig
g.EditorConfig_exclude_patterns = {'fugitive://.*'}

-- Emmet
g.user_emmet_expandabbr_key="<C-s>"

-- devicons
require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

-- Fugitive
keymap("n", "<leader>ga", ":Git add -A<CR>", opts)
keymap("n", "<leader>gs", ":Git<CR>", opts)
keymap("n", "<leader>gd", ":Gdiff<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>gl", ":Gclog<CR>", opts)
keymap("n", "<leader>gp", ":Git pull<CR>", opts)
keymap("n", "<leader>gh", ":Git push<CR>", opts)
keymap("n", "<leader>go", ":GBrowse<CR>", opts)

-- gitsigns
require('gitsigns').setup {}

-- hop
require'hop'.setup()
-- hop mappings
--mnemonic: word
vim.api.nvim_set_keymap('', '<leader>w', ":HopWordAC<cr>", {})
vim.api.nvim_set_keymap('', '<leader>W', ":HopWordBC<cr>", {})
--mnemonic: line
vim.api.nvim_set_keymap('', '<leader>l', ":HopLineAC<cr>", {})
vim.api.nvim_set_keymap('', '<leader>L', ":HopLineBC<cr>", {})
--mnemonic: hop (with hints)
vim.api.nvim_set_keymap('', '<leader>h', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', '<leader>H', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
--mnemonic: to or till (with hints)
vim.api.nvim_set_keymap('', '<leader>t', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('', '<leader>T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})

-- lualine
require('lualine').setup {
  options = {
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
  }, 
}

-- nvim-tree
require("nvim-tree").setup {
  actions = {
    open_file = {
      window_picker = {
        enable = false
      }
    }
  }
}
-- which-key
require("which-key").setup {}

-- Prettier
keymap("n", "<leader>re", "<Plug>(Prettier)", opts)
-- g.prettier#exec_cmd_async = 1
-- g.prettier#autoformat_config_present = 1

-- todo Comments
require("todo-comments").setup {}

--------------------------------------------------------------------------------
-- MACHINE SPECIFIC SETTINGS
--------------------------------------------------------------------------------

if fn.filereadable(fn.glob("$HOME/.config/localconfig/local.vim")) > 0 then
  vim.cmd [[source $HOME/.config/localconfig/local.lua]]
end
