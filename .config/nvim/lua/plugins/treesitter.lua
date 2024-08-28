require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = { "python", "r", "lua", "latex", "bibtex", "bash", "yaml", "json", "html", "css","rust"},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnm",
      node_decremental = "gnd",
      scope_incremental = "gsm"
      },
    },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]b"] = "@block.outer",
        ["]f"] = "@function.outer",
        ["]c"] = "@call.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]B"] = "@block.outer",
        ["]F"] = "@function.outer",
        ["]C"] = "@call.outer",
        ["]A"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[b"] = "@block.outer",
        ["[f"] = "@function.outer",
        ["[c"] = "@call.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[B"] = "@block.outer",
        ["[F"] = "@function.outer",
        ["[C"] = "@call.outer",
        ["[A"] = "@parameter.inner",
      },
    },
}
