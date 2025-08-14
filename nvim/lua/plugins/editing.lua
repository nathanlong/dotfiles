return {
  {
    'briandoll/change-inside-surroundings.vim',
    keys = {
      {'<leader>c', '<Cmd>ChangeInsideSurrounding<CR>'},
      {'<leader>C', '<Cmd>ChangeAroundSurrounding<CR>'}
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
    opts = {},
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
    opts = {},
  }
}
