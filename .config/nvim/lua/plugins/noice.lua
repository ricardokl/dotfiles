return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        -- command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      words = { enabled = false },
      scope = { enabled = false },
      dashboard = { enabled = false },
      statuscolumn = { enabled = true },
      quickfile = { enabled = true },
      bigfile = { enabled = true },
      scroll = { enabled = true },
      input = { enabled = false },
      indent = {
        enabled = true,
        chunk = {
          enabled = true,
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
      },
      notifier = {
        -- style = "minimal",
        style = "compact",
        enabled = true,
        timeout = 3000,
      },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      { "<leader>z",  function() Snacks.zen() end,                   desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end,              desc = "Toggle Zoom" },
      { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>nd", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.inlay_hints():map("<leader>ui")
        end,
      })
    end,
  }
}
