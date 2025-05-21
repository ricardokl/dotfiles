vim.lsp.config('*', {
  capabilities = require('bink.cmp').get_lsp_capabilities()
})

vim.lsp.config('luals', {
  settings = {
    Lua = {}
  },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
})

vim.lsp.enable('luals')
vim.lsp.enable('pyright')
vim.lsp.enable('vimls')
vim.lsp.enable('rust_analyzer')

