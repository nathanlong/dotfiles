return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function ()
      local configs = require('nvim-treesitter.configs')
      configs.setup({
        ensure_installed = { 'javascript', 'html', 'css', 'php', 'scss', 'typescript', 'vim', 'lua', 'yaml' },
        highlight = {
          enable = true,
          -- for things that may need additional synax help occasionally
          additional_vim_regex_highlighting = {'lua', 'css'},
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
        indent = {
          enable = true
        }
      })
    end
  }
}
