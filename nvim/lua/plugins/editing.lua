return {
  {
    'briandoll/change-inside-surroundings.vim',
    keys = {
      {'<leader>c', '<Cmd>ChangeInsideSurrounding<CR>', desc = 'Change inside surrounding'},
      {'<leader>C', '<Cmd>ChangeAroundSurrounding<CR>', desc = 'Change around surrounding'}
    }
  },
  {
    'numToStr/Comment.nvim',
    event = 'BufEnter'
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
      vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
      vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
      vim.keymap.set({'x', 'o'}, 'R',  function ()
        require('leap.treesitter').select {
          opts = require('leap.user').with_traversal_keys('R', 'r')
        }
      end)
    end
  },
  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },
  {
    'tpope/vim-surround',
    event = 'VeryLazy',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true
  },
  {
    'simnalamburt/vim-mundo',
    keys = {
      { '<F2>', '<Cmd>MundoToggle<cr>'}

    },
  }
}
