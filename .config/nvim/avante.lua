return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  opts = {
    provider = "groq",
    vendors = {
      straico = {
        __inherited_from = "openai",
        api_key_name = "STRAICO_API_KEY",
        endpoint = "http://127.0.0.1:8000/v1/",
        -- model = "anthropic/claude-3.5-sonnet",
        model = "openai/o1",
        timeout = 300000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },
    }
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