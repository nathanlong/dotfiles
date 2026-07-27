-- Overrides nvim-lspconfig's lsp/astro.lua. Must live in after/ -- rtp `lsp/*.lua`
-- files are merged last-wins, so a sibling in nvim/lsp/ loses to the plugin's copy.
local util = require 'lspconfig.util'

-- TS 7.x dropped typescript.js/tsserverlibrary.js from its npm package, but
-- get_typescript_server_path only checks that node_modules/typescript is a directory.
-- Volar-based astro-ls hard-asserts on those files, so a TS 7 project kills the server
-- at initialize. Verify the lib is really there, else fall back to the global TS.
local function usable(dir)
  return dir ~= '' and vim.uv.fs_stat(vim.fs.joinpath(dir, 'typescript.js')) ~= nil
end

---@type vim.lsp.Config
return {
  before_init = function(_, config)
    config.init_options = config.init_options or {}
    config.init_options.typescript = config.init_options.typescript or {}

    if config.init_options.typescript.tsdk then
      return
    end

    local tsdk = util.get_typescript_server_path(config.root_dir)
    if not usable(tsdk) then
      local npm_root = vim.fn.systemlist('npm root -g')
      if vim.v.shell_error == 0 and npm_root[1] then
        local global_tsdk = vim.fs.joinpath(npm_root[1], 'typescript/lib')
        tsdk = usable(global_tsdk) and global_tsdk or tsdk
      end
    end

    config.init_options.typescript.tsdk = tsdk
  end,
}
