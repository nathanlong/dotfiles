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
          slash_commands = {
            ['file'] = {
              -- Location to the slash command in CodeCompanion
              callback = 'strategies.chat.slash_commands.file',
              description = 'Select a file using Telescope',
              opts = {
                provider = 'telescope', -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                contains_code = true,
              },
            },
          },
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
