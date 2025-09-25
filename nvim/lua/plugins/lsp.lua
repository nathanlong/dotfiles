-- LSP
-- The main config files are in nvim/lsp and are enabled in init.vim
-- These config extend the main configs
-- Keymaps are in mappings.lua

local config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Extend capabilities for blink
  capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

  -- Capabilities required for the visualstudio lsps (css, html, etc)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- The VSCode language servers (cssls, html, jsonls) only provide completions when snippet support is enabled.
  vim.lsp.config('cssls', {
    capabilities = capabilities,
  })

  vim.lsp.config('html', {
    capabilities = capabilities,
  })

  vim.lsp.config('jsonls', {
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas {
          select = {
            '.eslintrc',
            'package.json',
            'block.json',
            'theme.json',
            'prettierrc.json'
          },
        },
        validate = { enable = true },
      },
    },
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'saghen/blink.cmp' },
      { 'b0o/schemastore.nvim' },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = config,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  }
}
