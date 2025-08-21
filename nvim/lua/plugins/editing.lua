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
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },
  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },
  {
    'kylechui/nvim-surround',
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
