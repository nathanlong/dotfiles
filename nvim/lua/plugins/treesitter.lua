-- @TODO revisit these settings with the 0.12 updates
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    main = 'nvim-treesitter.config',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'javascript', 'html', 'css', 'php', 'scss', 'typescript', 'vim', 'lua', 'yaml', 'twig' },
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
    }
  }
}
