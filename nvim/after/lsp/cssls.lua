-- cssls has no grammar for Tailwind v4's at-rules; silence the false errors.
-- (Does not restore property completion inside @theme/@utility -- that's a
-- parser limitation in vscode-css-languageservice, not a settings issue.)
---@type vim.lsp.Config
return {
  settings = {
    css = { lint = { unknownAtRules = 'ignore' } },
    scss = { lint = { unknownAtRules = 'ignore' } },
    less = { lint = { unknownAtRules = 'ignore' } },
  },
}
