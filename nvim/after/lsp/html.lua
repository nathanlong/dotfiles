-- Upstream narrowed filetypes to { 'html' }; keep the template languages attached.
---@type vim.lsp.Config
return {
  filetypes = { 'html', 'templ', 'eruby', 'twig' },
}
