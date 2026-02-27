return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'VeryLazy',
    keys = {
      { '<leader>a', '<Cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanion toggle'}
    },
    opts = {
      display = {
        chat = {
          show_settings = true,
        },
      },
      strategies = {
        chat = {
          adapter = 'anthropic',
        }
      },
      adapters = {
        http = {
          anthropic = function()
            local private = require 'user.private'
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = private.anthropic_api_key,
              },
              schema = {
                thinking_budget = {
                  default = 6500
                },
                max_tokens = {
                  default = 14000
                }
              },
            })
          end,
        },
      },
    },
  }
}
