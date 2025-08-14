return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        file_ignore_patterns = { '%.meta' },
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
        }
      }
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Tel files'})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Tel grep'})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Tel buffers'})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Tel help'})
      vim.keymap.set('n', '<leader>fm', builtin.oldfiles, { desc = 'Tel oldfiles'})
      vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = 'Tel command history'})
      vim.keymap.set('n', '<leader>fs', builtin.search_history, { desc = 'Tel search history'})
      vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Tel quickfix'})
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end
  }
}
