return {
  {
    "supermaven-inc/supermaven-nvim",
    enable = true,
    event = 'InsertEnter',
    opts = {
      keymaps = {
        accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
      },
      disable_inline_completion = true,
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    },
  },

  -- {
  --   -- "aliaksandr-trush/codeium.nvim", -- forked repo
  --   "Exafunction/codeium.vim",
  --   enable = true,
  --   -- event = "BufEnter",
  --   -- dependencies = {
  --   --   "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp",
  --   -- },
  --   otps = {},
  --   config = function()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<C-a>', function() return vim.fn['codeium#Complete']() end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
  --       { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
  --       { expr = true, silent = true })
  --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  --   end
  -- }
  --
}
