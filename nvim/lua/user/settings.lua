vim.opt.hidden = true -- Switch between buffers without saving
vim.opt.timeoutlen = 250 -- Lowers leader+command timeout.
vim.opt.clipboard = 'unnamedplus' -- Allow access to system clipboard
vim.opt.foldmethod = 'marker'
vim.opt.mouse = 'a' -- in most cases the mouse works just fine

-- Temp files, backups, and undos
vim.opt.directory = vim.fn.stdpath 'cache' .. '/tmp'  --Set temp directory
vim.g.nobackup = true --Get rid of backups, I don't use them
vim.g.nowb = true --Get rid of backups on write
vim.opt.swapfile = false --Get rid of swp files, I have never used them

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
vim.opt.titlestring = ' %t' -- just the name, and a fancy icon, weeeeee
vim.opt.titleold = 'zsh' -- does zsh not just reassert it's own title?
vim.opt.titlelen = 70
vim.opt.autoread = true -- Refresh files when changed outside of vim
vim.opt.number = true -- Line numbers
vim.opt.more = true -- Adds more prompt for long screen prints
vim.opt.ruler = true -- Cursor position in lower right
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case insensitive search
vim.opt.splitbelow = true -- split below the current window
vim.opt.splitright = true -- split vertical windows to the right
vim.opt.splitkeep = "screen" -- keep text on the same screen line when splitting
vim.opt.scrolloff = 4 -- always keeps cursor X lines from bottom
vim.opt.smoothscroll = true -- scroll by screen line, prevents long line 'chunk' scroll
vim.opt.eadirection = "hor" -- only equalize horz when splitting or closing
vim.opt.sidescrolloff = 8 -- keep X chars onscreen when nowrap is set
vim.opt.winminheight = 0 -- Allow splits to be squashed to one line
vim.opt.winminwidth = 0
vim.opt.laststatus = 3 -- v0.7+ only display one statusline for all splits, fancy!
-- chunkier dividers, helps me see splits better
-- vim.opt.fillchars:append {
--   horiz = '━',
--   horizup = '┻',
--   horizdown = '┳',
--   vert = '┃',
--   vertleft  = '┫',
--   vertright = '┣',
--   verthoriz = '╋'
-- }

-- Set invisible/whitespace markers, requires nerdfonts
vim.opt.list = true
vim.opt.listchars:append {
  -- eol = '¬',
  tab = ' ',
  trail = '⣿',
  extends = '»',
  precedes = '«',
}

-- Tab and Text
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true -- I really don't care all that much... team preference
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Colors
vim.opt.termguicolors = true -- Enable true color
vim.g.bg = "dark"

-- Local config enable (ex: .nvim.lua)
-- only set if you WANT to allow local overrides, displays trust dialog first
vim.opt.exrc = true
