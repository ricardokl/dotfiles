return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local default_model = "deepseek/deepseek-chat-v3-0324:free"
    local available_models = {
      "deepseek/deepseek-chat-v3-0324:free",
      "deepseek/deepseek-r1:free",
      "qwen/qwen3-235b-a22b:free",
    }
    local current_model = default_model

    local function select_model()
      vim.ui.select(available_models, {
        prompt = "Select  Model:",
      }, function(choice)
        if choice then
          current_model = choice
          vim.notify("Selected model: " .. current_model)
        end
      end)
    end

    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openrouter",
          -- adapter = "gemini"
        },
        inline = {
          adapter = "openrouter",
        },
        cmd = {
          adapter = "openrouter",
        },
      },
      adapters = {
        opts = {
          -- show_defaults = false,
          show_defaults = true,
        },
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = current_model,
              },
            },
          })
        end,
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<leader>cs", select_model, { desc = "Select Gemini Model" })
    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion Chat" },
    { "<leader>cc", "<cmd>CodeCompanion<cr>",            mode = "v",                  desc = "Code Companion Chat" },
  },
}
