return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opt = { ensure_installed = { "lua_ls" } }
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local servers = { 'pyright', 'vimls' }
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = function()
          vim.lsp.inlay_hint.enable(true)
        end,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--all-features" }
            },
            cargo = {
              features = "all"
            },
            check = {
              command = "clippy",
              features = "all"
            },
            inlayHints = { enable = true },
          }
        },
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            }
          }
        }
      })
    end
  },
}
