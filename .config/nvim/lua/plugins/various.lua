return {
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "dark",
      code_style = {
        functions = "underline",
        variables = "bold"
      }
    }
  },

  {
    "vimpostor/vim-tpipeline",
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },

  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },

  {
    "numToStr/Navigator.nvim",
    keys = {
      { '<c-h>', '<cmd>NavigatorLeft<cr>',     desc = "navigator move left" },
      { '<c-j>', '<cmd>NavigatorDown<cr>',     desc = "navigator move down" },
      { '<c-k>', '<cmd>NavigatorUp<cr>',       desc = "navigator move up" },
      { '<c-l>', '<cmd>NavigatorRight<cr>',    desc = "navigator move right" },
      { '<c-p>', '<cmd>NavigatorPrevious<cr>', desc = "navigator move previous" },
    },
    config = function()
      require('Navigator').setup({})
    end
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  {
    "echasnovski/mini.statusline",
    version = false,
    opts = {
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git           = MiniStatusline.section_git({ trunc_width = 40 })
          local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local filename      = MiniStatusline.section_filename({ trunc_width = 900 })
          local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 900 })
          local location      = MiniStatusline.section_location({ trunc_width = 900 })
          local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl,                 strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl,                  strings = { search, location } },
          })
        end
      }
    }
  },

  {
    'augmentcode/augment.vim',
    init = function()
      vim.g.augment_disable_tab_mapping = true
      vim.g.augment_workspace_folders = {
        -- '~/projects/onedark_nvim_rs/',
        -- '~/projects/aider/',
        -- '~/projects/straico-client/',
        -- '~/projects/straico-proxy/',
        -- '~/projects/aichat_nvim/',
        -- '~/projects/augment_extras/',
        -- '~/projects/gitsigns.nvim/',
        -- '~/projects/gitsignsrs_nvim/',
        '~/projects/codecompanion.nvim'
      }
    end
  },
}
