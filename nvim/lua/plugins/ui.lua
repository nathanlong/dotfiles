return {
  {
    'simnalamburt/vim-mundo',
    keys = {
      { '<F2>', '<Cmd>MundoToggle<CR>'}
    }
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {'<F1>', '<Cmd>NvimTreeToggle<cr>'}
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'catppuccin-mocha',
        component_separators = { left = '', right = ''},
      }
    }
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  },
  {
    's1n7ax/nvim-window-picker',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>w',
        function()
          local win = require('window-picker').pick_window()
          if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_current_win(win)
          end
        end,
        desc = 'Window Picker: Pick',
      },
    },
    config = function()
      require('window-picker').setup {
        hint = 'floating-big-letter',
        selection_chars = 'FJDKSLACMRUEIWOQPHTGYVBNZX',
        filter_rules = {
          autoselect_one = false,
          bo = {
            filetype = { 'notify', 'incline' },
            buftype = { 'quickfix' },
          },
        },
        picker_config = {
          floating_big_letter = {
            font = 'ansi-shadow',
          },
        },
        show_prompt = false,
      }
    end
  }
}
