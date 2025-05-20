return {

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local opts = {
        servers = {
          lua_ls = {
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
            settings = {
              Lua = {}
            }
          },
          rust_analyzer = {
            on_attach = function()
              vim.lsp.inlay_hint.enable(true)
            end,
            settings = {
              ['rust-analyzer'] = {
                checkOnSave = { true },
                inlayHints = { enable = true },
                cargo = { features = "all" },
              }
            },
            pyright = {},
            vimls = {},
          }
        },
      }
      local lspconfig = require("lspconfig")
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      for server, config in pairs(opts.servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end

      vim.diagnostic.config({
        update_in_insert = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          header = "",
          prefix = "",
        },
        virtual_text = true,
      })
    end
  }
}
