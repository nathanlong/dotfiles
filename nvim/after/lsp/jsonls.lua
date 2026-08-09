---@type vim.lsp.Config
return {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas {
        select = {
          '.eslintrc',
          'package.json',
          'block.json',
          'theme.json',
          'prettierrc.json',
        },
      },
      validate = { enable = true },
    },
  },
}
