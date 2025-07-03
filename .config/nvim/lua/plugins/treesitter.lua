return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      -- "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "python", "r", "lua", "latex", "bibtex", "bash", "yaml", "json", "html", "css", "rust", "markdown", "markdown_inline" },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<a-k>",
            node_incremental = "<a-k>",
            node_decremental = "<a-j>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@call.outer",
              ["ic"] = "@call.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["io"] = "@class.inner",
              ["ao"] = "@class.outer",
              ["ir"] = "@return.inner",
              ["ar"] = "@return.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function" },
              ["]c"] = { query = "@call.outer", desc = "Next call" },
              ["]a"] = { query = "@parameter.inner", desc = "Next argument" },
              ["]o"] = { query = "@class.inner", desc = "Next object" },
              ["]r"] = { query = "@return.inner", desc = "Next return" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Previous function" },
              ["[c"] = { query = "@call.outer", desc = "Previous call" },
              ["[a"] = { query = "@parameter.inner", desc = "Previous argument" },
              ["[o"] = { query = "@class.inner", desc = "Previous object" },
              ["[r"] = { query = "@return.inner", desc = "Previous return" },
            },
            goto_next_end = {
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
              ["]C"] = { query = "@call.outer", desc = "Next call end" },
              ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
              ["]O"] = { query = "@class.inner", desc = "Next object end" },
              ["]R"] = { query = "@return.inner", desc = "Next return end" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@function.outer", desc = "Previous function end" },
              ["[C"] = { query = "@call.outer", desc = "Previous call end" },
              ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
              ["[O"] = { query = "@class.inner", desc = "Previous object end" },
              ["[R"] = { query = "@return.inner", desc = "Previous return end" },
            },
          },
        },
      })
    end
  },
}
