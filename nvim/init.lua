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

-- User settings and keymaps
require('user.settings')
require('user.mappings')
require('user.autocommands')

-- Private local settings
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

-- rg as grep
-- if fn.executable("rg") > 0 then
--   vim.o.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
--   vim.opt.grepformat = { "%f:%l:%c:%m" }
-- end
