return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    config = function()
      require('luasnip.loaders.from_lua').lazy_load()
      vim.api.nvim_set_keymap('i', '<C-n>', '<Plug>luasnip-next-choice', {})
      vim.api.nvim_set_keymap('s', '<C-n>', '<Plug>luasnip-next-choice', {})
      vim.api.nvim_set_keymap('i', '<C-p>', '<Plug>luasnip-prev-choice', {})
      vim.api.nvim_set_keymap('s', '<C-p>', '<Plug>luasnip-prev-choice', {})
    end
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-n>'] = { 'snippet_forward', 'fallback' },
      ['<C-p>'] = { 'snippet_backward', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'show' },
      ['<Tab>'] = { 'select_next', 'show' },
      ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        update_delay_ms = 85,
        window = {
          max_height = 15,
          border = 'rounded',
        },
      },
    },
    signature = { enabled = true },
    snippets = { preset = 'luasnip' },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- See the fuzzy documentation for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' }
  },
  opts_extend = { 'sources.default' }
}
