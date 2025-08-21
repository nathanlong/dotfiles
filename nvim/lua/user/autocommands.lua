vim.api.nvim_create_augroup('setFiletype', { clear = true })
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  group = 'setFiletype',
  pattern = {'*.txt','*.text'},
  command = 'set filetype=markdown'
})

vim.api.nvim_create_augroup({'BufRead', 'BufNewFile'}, {
  group = 'setFiletype',
  pattern = '*.njk',
  command = 'set filetype=html'
})

vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = {'html', 'css', 'scss', 'vim', 'lua'},
  command = 'setlocal ts=2 sts=2 sw=2 expandtab iskeyword+=-'
})

vim.api.nvim_create_autocmd('Filetype', {
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
