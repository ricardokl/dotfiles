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

  -- {
  --   "jiangmiao/auto-pairs",
  -- },

  {
    "numToStr/Navigator.nvim",
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
    opts = {}
  },
}
