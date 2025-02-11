return {
  "yetone/avante.nvim",
  enable = false,
  event = "VeryLazy",
  lazy = false,
  opts = {
    provider = "groq",
    vendors = {
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
      },
      straico = {
        __inherited_from = "openai",
        api_key_name = "STRAICO_API_KEY",
        endpoint = "http://127.0.0.1:8000/v1/",
        model = "anthropic/claude-3.5-sonnet",
        disable_tools = true,
      }
    }
  },
  -- build = "make BUILD_FROM_SOURCE=true",
  build = "make",
  hints = { enabled = false },
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-telescope/telescope.nvim",
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
