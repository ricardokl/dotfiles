return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  opts = {
    provider = "groq",
  },
  build = "make BUILD_FROM_SOURCE=true",
  -- build = "make",
  hints = { enabled = false },
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
