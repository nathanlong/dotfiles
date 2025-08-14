return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {}
  },
  {
    'tpope/vim-fugitive',
    keys = {
      {'<leader>ga', '<Cmd>Git add -A<CR>', desc = 'Fugitive add all'},
      {'<leader>gs', '<Cmd>Git<CR>', desc = 'Fugitive status'},
      {'<leader>gd', '<Cmd>Gdiff<CR>', desc = 'Fugitive diff'},
      {'<leader>gb', '<Cmd>Git blame<CR>', desc = 'Fugitive blame'},
      {'<leader>gl', '<Cmd>Gclog<CR>', desc = 'Fugitive log'},
      {'<leader>gp', '<Cmd>Git pull<CR>', desc = 'Fugitive pull'},
      {'<leader>gh', '<Cmd>Git push<CR>', desc = 'Fugitive push'},
      {'<leader>go', '<Cmd>GBrowse<CR>', desc = 'Fugitive browse'}
    }
  },
  {
    'tpope/vim-rhubarb',
    event = 'VeryLazy',
  }

}
