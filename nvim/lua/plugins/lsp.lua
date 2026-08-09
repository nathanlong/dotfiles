-- LSP
-- Server configs ship with nvim-lspconfig (407 of them, on the runtimepath).
-- Our overrides live in nvim/after/lsp/<name>.lua -- deltas only, never full copies.
-- Precedence: lsp/ -> after/lsp/ -> vim.lsp.config(). Anything we write in nvim/lsp/
-- would LOSE to nvim-lspconfig's copy, so that directory is deliberately absent.
-- Which servers are enabled: see init.lua. Keymaps are in mappings.lua.

local config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Extend capabilities for blink
  capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

  -- The VSCode language servers (cssls, html, jsonls) only provide completions when
  -- snippet support is enabled. Harmless elsewhere, so apply it to every server.
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- '*' merges at the LOWEST precedence, so any after/lsp/ file still wins over it.
  vim.lsp.config('*', {
    capabilities = capabilities,
  })
end

return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
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
