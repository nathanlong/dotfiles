-- Completions inside cx()/clsx() calls and Astro's class: directives.
-- Everything else (classAttributes, includeLanguages, lint, root_dir) comes from upstream.
---@type vim.lsp.Config
return {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "class:\\s*?[\"'`]([^\"'`]*).*?," },
          { "class:\\s*['\"`]([^'\"`]*)['\"`]" },
          { "cx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" }, -- Classnames, ex. cx()
          { "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" }, -- clsx() for react
        },
      },
    },
  },
}
