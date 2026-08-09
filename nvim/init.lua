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

-- The servers we actually run. Configs come from nvim-lspconfig; our overrides (if any)
-- are in after/lsp/<name>.lua. Mason installs the binaries.
-- Globbing 'lsp/*.lua' off the runtimepath here would enable all ~420 servers that
-- nvim-lspconfig ships, not just ours -- hence the explicit list.
vim.lsp.enable({
  'astro',
  'cssls',
  'eslint',
  'html',
  'jsonls',
  'lua_ls',
  'oxfmt',
  'svelte',
  'tailwindcss',
  'ts_ls',
  'vimls',
  'vue_ls',
})
