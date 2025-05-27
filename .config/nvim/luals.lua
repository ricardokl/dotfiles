return {
  -- cmd = {"/data/data/com.termux/files/usr/bin/lua-language-server"},
  -- filetypes = {"lua"},
  -- root_markers = {'.luarc.json', '.luarc.jsonc'},
  settings = {
    Lua = {
      runtime = {
        -- LuaJIT in the case of 0.2.0 workaround.
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  -- on_init = function(client)
  --   if client.workspace_folders then
  --     local path = client.workspace_folders[1].name
  --     if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
  --       return
  --     end
  --   end
  --   client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
  --     runtime = {
  --       version = 'LuaJIT'
  --     },
  --     workspace = {
  --       checkThirdParty = false,
  --       library = {
  --         vim.env.VIMRUNTIME
  --       }
  --     }
  --   })
  -- end,
}
