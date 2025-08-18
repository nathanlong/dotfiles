-- Carryover vim aliases, consider abstracting?
local fn = vim.fn
local o = vim.opt
local g = vim.g
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local optsnos = { noremap = true }
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

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
o.titlestring = ' %t' -- just the name, and a fancy icon, weeeeee
o.titleold = 'zsh' -- does zsh not just reassert it's own title?
o.titlelen = 70
o.autoread = true -- Refresh files when changed outside of vim
o.number = true -- Line numbers
o.more = true -- Adds more prompt for long screen prints
o.ruler = true -- Cursor position in lower right
o.ignorecase = true -- case insensitive search
o.smartcase = true -- case insensitive search
o.splitbelow = true -- split below the current window
o.splitright = true -- split vertical windows to the right
o.splitkeep = "screen" -- keep text on the same screen line when splitting
o.scrolloff = 4 -- always keeps cursor X lines from bottom
o.smoothscroll = true -- scroll by screen line, prevents long line 'chunk' scroll
o.eadirection = "hor" -- only equalize horz when splitting or closing
o.sidescrolloff = 8 -- keep X chars onscreen when nowrap is set
o.winminheight = 0 -- Allow splits to be squashed to one line
o.winminwidth = 0
o.laststatus = 3 -- v0.7+ only display one statusline for all splits, fancy!
-- chunkier dividers, helps me see splits better
o.fillchars:append {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋'
}

-- Set invisible/whitespace markers, requires nerdfonts
o.list = true
o.listchars:append {
  -- eol = '¬',
  tab = ' ',
  trail = '⣿',
  extends = '»',
  precedes = '«',
}

-- Tab and Text
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.shiftround = true
o.expandtab = true -- I really don't care all that much... team preference
o.smartindent = true
o.autoindent = true

-- Colors
o.termguicolors = true -- Enable true color
g.bg = "dark"

-- Local config enable (ex: .nvim.lua)
-- only set if you WANT to allow local overrides, displays trust dialog first
o.exrc = true
