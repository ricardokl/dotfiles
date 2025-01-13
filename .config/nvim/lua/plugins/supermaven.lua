return {
  {
    "supermaven-inc/supermaven-nvim",
    enable = false,
    event = 'InsertEnter',
    opts = {
      keymaps = {
        accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
      },
      disable_inline_completion = true,
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    },
  }
  -- lazy = false,
  -- config = function()
  --     require("supermaven-nvim").setup({
  --       disable_inline_completion = true
  --     })
  --   end
  -- },

  -- {
  --   "aliaksandr-trush/codeium.nvim", -- forked repo
  --   -- "Exafunction/codeium.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup({
  --     })
  --   end
  -- }
}
