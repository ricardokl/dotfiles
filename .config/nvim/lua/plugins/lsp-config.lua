return {

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      -- "hrsh7th/nvim-cmp",
      -- "L3MON4D3/LuaSnip",
      -- "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-nvim-lsp",
      -- "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-cmdline",
      -- "onsails/lspkind.nvim",
      -- "rafamadriz/friendly-snippets",
      -- "hrsh7th/cmp-nvim-lua",
      -- "ray-x/cmp-treesitter",
    },
    config = function()
      -- require('cmp_nvim_lsp').setup({})
      -- require("luasnip.loaders.from_vscode").lazy_load()

      -- local lspkind = require("lspkind")
      -- local cmp = require("cmp")
      -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
      -- cmp.setup({
      --   formatting = {
      --     format = lspkind.cmp_format({
      --       mode = 'symbol_text',
      --       maxwidth = {
      --         menu = 50,
      --         abbr = 50,
      --       },
      --       ellipsis_char = '...',
      --       show_labelDetails = true,
      --     })
      --   },
      --   snippet = {
      --     expand = function(args)
      --       require("luasnip").lsp_expand(args.body)
      --     end,
      --   },
      --   experimental = { ghost_text = false },
      --   mapping = cmp.mapping.preset.insert({
      --     ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      --     ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      --     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
      --     ['<C-c>'] = cmp.mapping.complete(),
      --     ['<C-q>'] = cmp.mapping.abort(),
      --     ['<CR>'] = cmp.mapping.confirm({ select = true }),
      --     ['<Tab>'] = function(fallback)
      --       if cmp.visible() then
      --         cmp.select_next_item()
      --       elseif require("luasnip").expand_or_jumpable() then
      --         require("luasnip").expand_or_jump()
      --       else
      --         fallback()
      --       end
      --     end,
      --     ['<S-Tab>'] = function(fallback)
      --       if cmp.visible() then
      --         cmp.select_prev_item()
      --       elseif require("luasnip").jumpable(-1) then
      --         require("luasnip").jump(-1)
      --       else
      --         fallback()
      --       end
      --     end,
      --   }),
      --   sources = cmp.config.sources({
      --     { name = 'nvim_lsp',   keyword_lengh = 2 },
      --     { name = 'treesitter', keyword_lengh = 2 },
      --     { name = 'path',       keyword_lengh = 2 },
      --     { name = 'luasnip',    keyword_lengh = 3 },
      --     { name = 'cmdline',    keyword_lengh = 2 },
      --   }, {
      --     { name = 'buffer', keyword_lengh = 3 },
      --   }),
      -- })
      --
      -- cmp.setup.filetype('lua', {
      --   sources = cmp.config.sources({
      --     { name = 'nvim_lsp' },
      --     { name = 'nvim_lua',  keyword_lengh = 1 },
      --     { name = 'treesitter' },
      --     { name = 'path' },
      --     { name = 'luasnip',   keyword_lengh = 2 },
      --     { name = 'cmdline',   keyword_lengh = 2 },
      --   }, {
      --     { name = 'buffer', keyword_lengh = 3 },
      --   })
      -- })
      --
      -- cmp.setup.cmdline({ '/', '?' }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   }
      -- })
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     { name = 'cmdline' }
      --   }),
      --   matching = { disallow_symbol_nonprefix_matching = false }
      -- })

      local servers = { 'pyright', 'vimls' }
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      lspconfig.rust_analyzer.setup({
        cmd = { '/home/ricardo/.cargo/bin/rust-analyzer' },
        capabilities = capabilities,
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
      })

      lspconfig.lua_ls.setup {
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
      }

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
  },
}
