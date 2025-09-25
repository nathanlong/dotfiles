-- Use the experimental Lua module loader (does byte-caching)
vim.loader.enable()

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- User config
require('user.settings')
require('user.mappings')
require('user.autocommands')
require('user.functions')

-- Private local config (if available)
pcall(require, 'user.local')

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  install = {
    colorscheme = { 'catppuccin-mocha', 'habamax'}
  },
  checker = { enabled = true },
})

-- Post plugin settings
vim.cmd.colorscheme 'catppuccin-mocha'

-- enable all LSPs defined under lsp/
vim.lsp.enable(vim
  .iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
  :map(function(f)
    return vim.fn.fnamemodify(f, ':t:r')
  end)
  :totable())
