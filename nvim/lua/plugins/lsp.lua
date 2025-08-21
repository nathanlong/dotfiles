local config = function()
  local lspconfig = require('lspconfig')
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Extend capabilities for blink
  capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

  -- Capabilities required for the visualstudio lsps (css, html, etc)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings to magical LSP functions!
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    local function opts_with_desc(desc)
      return vim.tbl_extend('force', bufopts, { desc = desc })
    end

    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.declaration, opts_with_desc('LSP Declaration'))
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts_with_desc('LSP Definition'))
    vim.keymap.set('n', '<leader>lk', vim.lsp.buf.hover, opts_with_desc('LSP Hover'))
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts_with_desc('LSP Implementation'))
    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts_with_desc('LSP Signature Help'))
    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts_with_desc('LSP Type Definition'))
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts_with_desc('LSP Rename'))
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts_with_desc('LSP Code Action'))
    vim.keymap.set('n', '<leader>le', vim.lsp.buf.references, opts_with_desc('LSP References'))
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts_with_desc('LSP Format'))
  end

  lspconfig.lua_ls.setup ({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        diagnostics = {
          enable = true,
          globals = {'vim'}
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
        telemetry = { enable = false },
      },
    },
  })

  -- Set up each LSP server
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

  lspconfig.cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

  lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

  lspconfig.eslint.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

  lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

  lspconfig.jsonls.setup({
    on_attach = on_attach,
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

  lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            { "class:\\s*?[\"'`]([^\"'`]*).*?," },
            { "cx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" }, -- Classnames, ex. cx()
          }
        }
      }
    }
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
