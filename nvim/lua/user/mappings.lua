-- Common mapping options
local opts = { noremap = true, silent = true }
local optsnos = { noremap = true }

-- Allow default opts with unique desc
-- Most useful for leader key combos + which-key.nvim plugin
local function opts_with_desc(desc)
  return vim.tbl_extend('force', opts, { desc = desc })
end

-- Remove default neovim map for line yank (too much muscle memory)
vim.api.nvim_del_keymap('n', 'Y')

-- Remap space as leader key
vim.keymap.set('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Map : to ; (then remap ;) -- massive pinky-saver
vim.keymap.set('n', ';', ':', opts)
vim.keymap.set('n', '<M-;>', ';', opts)

-- Remap j and k to act as expected when used on wrapped lines
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
vim.keymap.set('n', '<C-A-k>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-A-j>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-A-h>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-A-l>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
vim.keymap.set('n', '<leader>b', '<C-^>', opts_with_desc('Last edited buffer')) -- last edited buffer (super useful!)
vim.keymap.set('n', '<S-l>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', opts)

-- Tab selection
vim.keymap.set('n', '<leader>1', '1gt', opts)
vim.keymap.set('n', '<leader>2', '2gt', opts)
vim.keymap.set('n', '<leader>3', '3gt', opts)
vim.keymap.set('n', '<leader>4', '4gt', opts)
vim.keymap.set('n', '<leader>5', '5gt', opts)
vim.keymap.set('n', '<leader>6', '6gt', opts)
vim.keymap.set('n', '<leader>7', '7gt', opts)
vim.keymap.set('n', '<leader>8', '8gt', opts)
vim.keymap.set('n', '<leader>9', '9gt', opts)

-- emac style jump to end of line in insert mode
-- checks for autocomplete menu
vim.keymap.set('i', '<C-e>', 'pumvisible() ? "\\<C-e>" : "\\<C-o>A"', {expr = true})
vim.keymap.set('i', '<C-a>', '<C-o>I', opts)

-- Better escape from insert mode
vim.keymap.set('i', 'jk', '<Esc>', opts)

-- LINE MANIPULATION = <alt> + direction, + <shift> for duplication
-- Bubble lines, move text up and down
-- Make sure iTerm has the option ket set to 'Esc+' for Alt bindings
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', opts)
-- vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
-- vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Map indent like line manipulation
vim.keymap.set('n', '<A-h>', '<<', opts)
vim.keymap.set('n', '<A-l>', '>>', opts)
vim.keymap.set('x', '<A-h>', '<gv', opts)
vim.keymap.set('x', '<A-l>', '>gv', opts)

-- Duplicate lines above and below
vim.keymap.set('n', '<S-A-j>', 'Ypk', opts)
vim.keymap.set('i', '<S-A-j>', '<esc>Ypk', opts)
vim.keymap.set('x', '<S-A-j>', 'y`>pgv', opts)
vim.keymap.set('n', '<S-A-k>', 'YPj', opts)
vim.keymap.set('i', '<S-A-k>', '<esc>YPj', opts)
vim.keymap.set('x', '<S-A-k>', 'y`<Pgv', opts)

-- Remove search highlighting
vim.keymap.set('n', '<leader><cr>', ':noh<cr>', opts_with_desc('Remove highlighting'))

-- Toggle invisibles
vim.keymap.set('n', '<leader>I', ':set list!<CR>', opts_with_desc('Toggle invisibles'))

-- Grab line without newline
vim.keymap.set('n', '<leader>L', '^vg_', opts_with_desc('Select line w/o newline'))

-- Will open files in current directory, allows you to leave the working cd in
-- the project root. You can also use %% anywhere in the command line.
vim.api.nvim_set_keymap('c', '%%', '<C-R>=expand("%:h")."/"<cr>', optsnos)
-- We need these to be recursive, so don't use noremap
vim.api.nvim_set_keymap('n', '<leader>ew', ':e %%', { desc = 'Edit in this window'})
vim.api.nvim_set_keymap('n', '<leader>es', ':sp %%', { desc = 'Edit in split'})
vim.api.nvim_set_keymap('n', '<leader>ev', ':vsp %%', { desc = 'Edit in vert split'})
vim.api.nvim_set_keymap('n', '<leader>et', ':tabe %%', { desc = 'Edit in tab'})

-- Regex for git conflict markers
vim.keymap.set('n', '<leader>m', '/\\v[<=>]{7}<cr>', opts_with_desc('Git conflict markers'))

-- Quick terminal windows
vim.keymap.set( 'n', '<leader>tv', [[<cmd>vsplit | term<cr>A]], { desc = 'Open terminal in vertical split' })
vim.keymap.set( 'n', '<leader>th', [[<cmd>split | term<cr>A]], { desc = 'Open terminal in horizontal split' })

-- LSP bindings
vim.keymap.set('n', '<leader>lc', vim.lsp.buf.declaration, opts_with_desc('LSP Declaration'))
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts_with_desc('LSP Definition'))
vim.keymap.set('n', '<leader>lk', vim.lsp.buf.hover, opts_with_desc('LSP Hover'))
vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts_with_desc('LSP Implementation'))
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts_with_desc('LSP Signature Help'))
vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts_with_desc('LSP Type Definition'))
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts_with_desc('LSP Rename'))
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts_with_desc('LSP Code Action'))
vim.keymap.set('n', '<leader>le', vim.lsp.buf.references, opts_with_desc('LSP References'))
vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts_with_desc('LSP Format'))
