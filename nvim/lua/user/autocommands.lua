-- Carryover vim aliases, consider abstracting?
local fn = vim.fn
local o = vim.opt
local g = vim.g
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local optsnos = { noremap = true }
local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

augroup('setFiletype', { clear = true })
autocmd({'BufRead', 'BufNewFile'}, {
  group = 'setFiletype',
  pattern = {'*.txt','*.text'},
  command = 'set filetype=markdown'
})

autocmd({'BufRead', 'BufNewFile'}, {
  group = 'setFiletype',
  pattern = '*.njk',
  command = 'set filetype=html'
})

augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = {'html', 'css', 'scss', 'vim', 'lua'},
  command = 'setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-'
})

autocmd('Filetype', {
  group = 'setIndent',
  pattern = {'markdown'},
  command = 'setlocal ts=2 sts=2 sw=2 fo=qrn1 expandtab spell'
})

-- autocommands I have yet to rewrite in lua...
vim.cmd [[
  augroup vimrcEx
    autocmd!
    " Open to last line after close
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  augroup END
]]
