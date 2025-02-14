return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "supermaven-inc/supermaven-nvim",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
    },
    config = function()
      require('cmp_nvim_lsp').setup({})
      require("luasnip.loaders.from_vscode").lazy_load()
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = {
              menu = 50,              -- leading text (labelDetails)
              abbr = 50,              -- actual suggestion item
            },
            ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          })
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        experimental = { ghost_text = true },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.complete(),
          ['<C-a>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp',   keyword_lengh = 2 },
          { name = 'treesitter', keyword_lengh = 2 },
          { name = 'path',       keyword_lengh = 2 },
          { name = 'luasnip',    keyword_lengh = 3 },
          { name = 'cmdline',    keyword_lengh = 2 },
        }, {
          { name = 'buffer', keyword_lengh = 3 },
          -- { name = 'vsnip' },
        }),
      })
      cmp.setup.filetype('lua', {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lua',  keyword_lengh = 1 },
          { name = 'treesitter' },
          { name = 'path' },
          { name = 'luasnip',   keyword_lengh = 2 },
          { name = 'cmdline',   keyword_lengh = 2 },
        }, {
          { name = 'buffer', keyword_lengh = 3 },
        })
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },
}
