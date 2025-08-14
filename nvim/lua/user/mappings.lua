-- Carryover vim aliases, consider abstracting?
local fn = vim.fn
local o = vim.opt
local g = vim.g
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local optsnos = { noremap = true }
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Remove default neovim map for line yank (too much muscle memory)
vim.api.nvim_del_keymap('n', 'Y')

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
g.mapleader = ' '
g.maplocalleader = ' '

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Map : to ; (then remap ;) -- massive pinky-saver
keymap('n', ';', ':', opts)
keymap('n', '<M-;>', ';', opts)

-- Remap j and k to act as expected when used on wrapped lines
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-A-k>', ':resize -2<CR>', opts)
keymap('n', '<C-A-j>', ':resize +2<CR>', opts)
keymap('n', '<C-A-h>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-A-l>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<leader>b', '<C-^>', opts) -- last edited buffer (super useful!)
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Tab selection
keymap('n', '<leader>1', '1gt', opts)
keymap('n', '<leader>2', '2gt', opts)
keymap('n', '<leader>3', '3gt', opts)
keymap('n', '<leader>4', '4gt', opts)
keymap('n', '<leader>5', '5gt', opts)
keymap('n', '<leader>6', '6gt', opts)
keymap('n', '<leader>7', '7gt', opts)
keymap('n', '<leader>8', '8gt', opts)
keymap('n', '<leader>9', '9gt', opts)

-- emac style jump to end of line in insert mode
-- checks for autocomplete menu
keymap('i', '<C-e>', 'pumvisible() ? "\\<C-e>" : "\\<C-o>A"', {expr = true})
keymap('i', '<C-a>', '<C-o>I', opts)

-- Better escape from insert mode
keymap('i', 'jk', '<Esc>', opts)

-- LINE MANIPULATION = <alt> + direction, + <shift> for duplication
-- Bubble lines, move text up and down
-- Make sure iTerm has the option ket set to 'Esc+' for Alt bindings
keymap('n', '<A-j>', ':m .+1<CR>==', opts)
keymap('n', '<A-k>', ':m .-2<CR>==', opts)
-- keymap('v', '<A-j>', ':m .+1<CR>==', opts)
-- keymap('v', '<A-k>', ':m .-2<CR>==', opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Map indent like line manipulation
keymap('n', '<A-h>', '<<', opts)
keymap('n', '<A-l>', '>>', opts)
keymap('x', '<A-h>', '<gv', opts)
keymap('x', '<A-l>', '>gv', opts)

-- Duplicate lines above and below
keymap('n', '<S-A-j>', 'Ypk', opts)
keymap('i', '<S-A-j>', '<esc>Ypk', opts)
keymap('x', '<S-A-j>', 'y`>pgv', opts)
keymap('n', '<S-A-k>', 'YPj', opts)
keymap('i', '<S-A-k>', '<esc>YPj', opts)
keymap('x', '<S-A-k>', 'y`<Pgv', opts)

-- Remove search highlighting
keymap('n', '<leader><cr>', ':noh<cr>', opts)

-- Toggle invisibles
keymap('n', '<leader>I', ':set list!<CR>', opts)

-- Grab line without newline
keymap('n', '<leader>L', '^vg_', opts)

-- Will open files in current directory, allows you to leave the working cd in
-- the project root. You can also use %% anywhere in the command line.
keymap('c', '%%', '<C-R>=expand("%:h")."/"<cr>', optsnos)
-- We need these to be recursive, so don't use noremap
keymap('n', '<leader>ew', ':e %%', {})
keymap('n', '<leader>es', ':sp %%', {})
keymap('n', '<leader>ev', ':vsp %%', {})
keymap('n', '<leader>et', ':tabe %%', {})

-- Regex for git conflict markers
keymap('n', '<leader>m', '/\\v[<=>]{7}<cr>', opts)
