return {
  {
    'prettier/vim-prettier',
    ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'},
    build = 'yarn install --frozen-lockfile --production',
    keys = {
      {'<leader>re', ':Prettier<cr>', mode = 'n', desc = 'Format buffer w/Prettier'},
      {'<leader>re', ':PrettierFragment<cr>', mode = 'v', desc = 'Format selection w/Prettier'}
    }
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        json = { "oxfmt" },
        vue = { "oxfmt" },
      },
    },
    keys = {
      {'<leader>co', '<cmd>lua require("conform").format()<cr>', mode = 'n', desc = 'Format buffer w/oxfmt'},
    }
  }
}
